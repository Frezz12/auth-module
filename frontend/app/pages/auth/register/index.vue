<script setup lang="ts">
import * as v from 'valibot'
import type { FormSubmitEvent } from '@nuxt/ui'
import { useAuth, usePocketBase } from '~/lib/usePocketbase';

const auth = useAuth();
const pb = usePocketBase()

const state = reactive({
    name: '',
    email: '',
    password: '',
    confirmPassword: ''
})

const onSubmit = async () => {
  try {
    await auth.register({
      name: state.name,
      email: state.email,
      password: state.password,
      confirmPassword: state.confirmPassword
      
    })

    await auth.authUserWithPassword({
      email: state.email,
      password: state.password
    })

    await navigateTo( `/profile/${pb.authStore.record?.id}`, { external: true })
  } catch (err) {
    console.log(err)
  }
}

</script>

<template>
  <div class="flex flex-col justify-center items-center h-screen  bg-[#171717] bg-[radial-gradient(#353945_1px,transparent_1px)] [background-size:16px_16px] bg-[size:80px_80px] animate-grid-scroll">
    <UForm :state="state" class="space-y-4 bg-[#171717] p-16 border border-white/40 rounded-2xl" @submit="onSubmit">
      <UFormField label="Name" name="name">
        <UInput v-model="state.name" />
      </UFormField>

      <UFormField label="Email" name="email">
        <UInput v-model="state.email" />
      </UFormField>

      <UFormField label="Password" name="password">
        <UInput v-model="state.password" type="password" />
      </UFormField>

      <UFormField label="Confirm Password" name="confirmPassword">
        <UInput v-model="state.confirmPassword" type="password" />
      </UFormField>

      <UButton type="submit">
        Register
      </UButton>
    </UForm>
  </div>
</template>