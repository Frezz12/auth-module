<script setup lang="ts">
import type { UsersRecord } from '~/lib/pocketbase-types';
import { usePocketBase } from '~/lib/usePocketbase';

const pb = usePocketBase()

const route = useRoute()
const userID = ref<string>(route.params.id as string)

const user = ref<UsersRecord | null>(null)

onMounted(async () => {
    try {
        user.value = await pb.collection('users').getOne(userID.value)
    } catch (err) {
        console.log(err)
    }
})
</script>

<template>
    <div class="flex flex-col justify-center items-center h-screen bg-[#171717] text-white">
        <p>Привет, {{ user?.name }}</p>
    </div>
</template>