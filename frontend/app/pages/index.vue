<template>
  <div class="flex flex-col justify-center items-center h-screen">
    <div class="w-10 flex flex-col justify-center items-center gap-3">
      <NuxtLink class=" hover:text-black/50" to="auth/login">
          Войти
      </NuxtLink>
      <NuxtLink to="auth/register">
          Регистрация
      </NuxtLink>
    </div>
  </div>
</template>
