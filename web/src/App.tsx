import { Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import Home from './pages/Home'
import SignIn from './pages/SignIn'
import Account from './pages/Account'
import NotFound from './pages/NotFound'
import SplicePalProduct from './pages/splicepal/Product'
import SplicePalPrivacy from './pages/splicepal/Privacy'
import SplicePalSupport from './pages/splicepal/Support'
import SplicePalTraining from './pages/splicepal/TrainingIndex'
import SplicePalArticle from './pages/splicepal/TrainingArticle'
import WeldPalProduct from './pages/weldpal/Product'
import WeldPalPrivacy from './pages/weldpal/Privacy'
import WeldPalSupport from './pages/weldpal/Support'
import WeldPalTraining from './pages/weldpal/TrainingIndex'
import WeldPalArticle from './pages/weldpal/TrainingArticle'

export default function App() {
  return (
    <Routes>
      <Route element={<Layout />}>
        <Route index element={<Home />} />
        <Route path="signin" element={<SignIn />} />
        <Route path="account" element={<Account />} />

        <Route path="splicepal" element={<SplicePalProduct />} />
        <Route path="splicepal/privacy" element={<SplicePalPrivacy />} />
        <Route path="splicepal/support" element={<SplicePalSupport />} />
        <Route path="splicepal/training" element={<SplicePalTraining />} />
        <Route path="splicepal/training/:slug" element={<SplicePalArticle />} />

        <Route path="weldpal" element={<WeldPalProduct />} />
        <Route path="weldpal/privacy" element={<WeldPalPrivacy />} />
        <Route path="weldpal/support" element={<WeldPalSupport />} />
        <Route path="weldpal/training" element={<WeldPalTraining />} />
        <Route path="weldpal/training/:slug" element={<WeldPalArticle />} />

        <Route path="*" element={<NotFound />} />
      </Route>
    </Routes>
  )
}
