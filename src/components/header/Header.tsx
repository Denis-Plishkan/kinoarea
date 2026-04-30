'use client'

import Image from 'next/image'
import { Navigate } from './Navigate'
import { MdSearch } from 'react-icons/md'
import Link from 'next/link'
import { BurgerMenu } from './BurgerMenu'

export const Header = () => (
  <header className="flex items-center justify-between p-2">
    <BurgerMenu />
    <Link href="/">
      <Image
        src="/logo.svg"
        alt="logo"
        width={120}
        height={40}
        priority
        className="h-auto w-full"
      />
    </Link>

    <div className="hidden lg:block">
      <Navigate />
    </div>

    <div className="flex items-center gap-2">
      <button className="flex h-12 cursor-pointer items-center justify-center rounded bg-white transition hover:bg-blue-100 lg:w-12">
        <MdSearch className="text-blue-500" size={24} />
      </button>
      <button className="button cursor-pointer">Войти</button>
    </div>
  </header>
)
