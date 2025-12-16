<script setup lang="ts">
import * as v from 'valibot'
import type { FormSubmitEvent } from '@nuxt/ui'
import { useAuth, useAuthenticated, usePocketBase } from '~/lib/usePocketbase'
import type { UsersRecord } from '~/lib/pocketbase-types';

const auth = useAuth();
const pb = usePocketBase()

const state = reactive({
    email: '',
    password: '',
})

const onSubmit = async () => {
  try {
    await auth.authUserWithPassword({
      email: state.email,
      password: state.password
    })
    await navigateTo( `/profile/${pb.authStore.record?.id}`, { external: true })
  } catch (err) {
    console.log(err)
  }
}

useAuthenticated()
</script>

<template>
    <div class="flex flex-col justify-center items-center h-screen bg-[#171717]">
        <UForm :state="state" class="space-y-4 bg-white/3 p-16 border border-white/40 rounded-2xl " @submit="onSubmit">
            <p class="flex justify-center font-bold text-2xl"> 
              АВТОРИЗАЦИЯ
            </p>

            <UFormField size="xl" class="w-full" label="Email" name="email">
                <UInput v-model="state.email" />
            </UFormField>

            <UFormField size="xl" class="w-full" label="Пароль" name="Пароль">
                <UInput v-model="state.password" type="password" />
            </UFormField>

            <UButton size="xl" class="w-full flex justify-center items-center cursor-pointer" type="submit">
                Войти
            </UButton>
        </UForm>
    </div>
</template>