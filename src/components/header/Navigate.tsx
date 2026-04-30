import { navLinks } from '@/constants/navigation'
import Link from 'next/link'

export const Navigate = () => {
  return (
    <nav>
      <ul className="flex gap-6">
        {navLinks.map(link => (
          <li key={link.href}>
            <Link href={link.href} className="transition hover:text-blue-200">
              {link.name}
            </Link>
          </li>
        ))}
      </ul>
    </nav>
  )
}
