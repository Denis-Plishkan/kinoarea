'use client'

import Tabs from '@mui/material/Tabs'
import Tab from '@mui/material/Tab'
import { useState } from 'react'

interface FilterTabsProps {
  items: string[]
  defaultValue?: number
  onChange?: (value: string | undefined, index: number) => void
  allLabel?: string
}

export const FilterTabs = ({
  items,
  defaultValue = 0,
  onChange,
  allLabel = 'Все',
}: FilterTabsProps) => {
  const [value, setValue] = useState(defaultValue)

  const handleChange = (event: React.SyntheticEvent, value: number) => {
    setValue(value)
    const selectedValue = items[value] === allLabel ? undefined : items[value]
    onChange?.(selectedValue, value)
  }
  return (
    <Tabs
      value={value}
      onChange={handleChange}
      sx={{
        '& .MuiTab-root': {
          color: 'gray',
          textTransform: 'none',
          '&.Mui-selected': {
            color: '#fff',
          },
        },
        '& .MuiTabs-indicator': {
          display: 'none',
        },
      }}
    >
      {items.map(item => (
        <Tab key={item} label={item} />
      ))}
    </Tabs>
  )
}
