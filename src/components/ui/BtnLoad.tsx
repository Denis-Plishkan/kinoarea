interface BtnLoadProps {
    handleLoadMore: () => void
    isPending: boolean
}

export const BtnLoad = ({handleLoadMore, isPending}: BtnLoadProps) => {
  return (
    <div className="text-center">
      <button
        onClick={handleLoadMore}
        disabled={isPending}
        className="h-17 w-50 cursor-pointer rounded border-2 transition hover:bg-blue-500/70"
      >
        {isPending ? 'Загрузка...' : 'Загрузить ещё'}
      </button>
    </div>
  )
}
