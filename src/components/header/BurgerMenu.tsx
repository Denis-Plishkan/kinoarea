'use client'
import { navLinks } from '@/constants/navigation'
import { useState } from 'react'
import { MdClose, MdMenu } from 'react-icons/md'
import Link from 'next/link'

export const BurgerMenu = () => {
  const [isOpen, setIsOpen] = useState(false)

  return (
    <div className="lg:hidden">
      <button onClick={() => setIsOpen(!isOpen)}>
        {isOpen ? <MdClose size={26} /> : <MdMenu size={26} />}
      </button>

      {isOpen && (
        <>
          <nav className="fixed top-0 left-0 z-50 h-screen w-full bg-[#1e2538] p-6">
            <button
              onClick={() => setIsOpen(false)}
              className="absolute top-4 right-4"
            >
              <MdClose size={24} />
            </button>
            <ul className="mt-12 flex flex-col items-center gap-4">
              {navLinks.map(link => (
                <li key={link.href}>
                  <Link href={link.href} onClick={() => setIsOpen(false)}>
                    {link.name}
                  </Link>
                </li>
              ))}
            </ul>
          </nav>
        </>
      )}
    </div>
  )
}
