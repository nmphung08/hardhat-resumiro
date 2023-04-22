import Header from '@/src/components/Header'
import { Web3Provider } from '@/src/context/Web3Context'
import '@/styles/globals.css'
import type { AppProps } from 'next/app'

export default function App({ Component, pageProps }: AppProps) {
  return (
    <Web3Provider>
      <Header/>
      <Component {...pageProps} />
    </Web3Provider>
  )
}
