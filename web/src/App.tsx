import { Routes, Route, useLocation } from 'react-router-dom'
import { useEffect } from 'react'
import Layout from './components/Layout'
import Home from './pages/Home'
import About from './pages/About'
import Training from './pages/Training'
import SignIn from './pages/SignIn'
import Account from './pages/Account'
import NotFound from './pages/NotFound'
import SplicePalProduct from './pages/splicepal/Product'
import SplicePalPrivacy from './pages/splicepal/Privacy'
import SplicePalTerms from './pages/splicepal/Terms'
import SplicePalSupport from './pages/splicepal/Support'
import SplicePalTraining from './pages/splicepal/TrainingIndex'
import SplicePalModules from './pages/splicepal/TrainingModules'
import SplicePalModule from './pages/splicepal/TrainingModule'
import SplicePalArticle from './pages/splicepal/TrainingArticle'
import SplicePalExam from './pages/splicepal/TrainingExam'
import SplicePalExamRun from './pages/splicepal/TrainingExamRun'
import SplicePalReadiness from './pages/splicepal/TrainingReadiness'
import SplicePalSR from './pages/splicepal/TrainingSR'
import WeldPalProduct from './pages/weldpal/Product'
import WeldPalPrivacy from './pages/weldpal/Privacy'
import WeldPalTerms from './pages/weldpal/Terms'
import WeldPalSupport from './pages/weldpal/Support'
import WeldPalTraining from './pages/weldpal/TrainingIndex'
import WeldPalModules from './pages/weldpal/TrainingModules'
import WeldPalModule from './pages/weldpal/TrainingModule'
import WeldPalExam from './pages/weldpal/TrainingExam'
import WeldPalExamRun from './pages/weldpal/TrainingExamRun'
import WeldPalReadiness from './pages/weldpal/TrainingReadiness'
import WeldPalSR from './pages/weldpal/TrainingSR'
import WeldPalArticle from './pages/weldpal/TrainingArticle'
import PoolPalProduct from './pages/poolpal/Product'
import PoolPalPrivacy from './pages/poolpal/Privacy'
import PoolPalTerms from './pages/poolpal/Terms'
import PoolPalSupport from './pages/poolpal/Support'
import VoltPalProduct from './pages/voltpal/Product'
import VoltPalPrivacy from './pages/voltpal/Privacy'
import VoltPalTerms from './pages/voltpal/Terms'
import VoltPalSupport from './pages/voltpal/Support'
import VoltPalTraining from './pages/voltpal/TrainingIndex'
import VoltPalArticle from './pages/voltpal/TrainingArticle'
import PipePalProduct from './pages/pipepal/Product'
import PipePalPrivacy from './pages/pipepal/Privacy'
import PipePalTerms from './pages/pipepal/Terms'
import PipePalSupport from './pages/pipepal/Support'
import PipePalTraining from './pages/pipepal/TrainingIndex'
import PipePalArticle from './pages/pipepal/TrainingArticle'

function ScrollToTop() {
  const { pathname } = useLocation()
  useEffect(() => { window.scrollTo(0, 0) }, [pathname])
  return null
}

export default function App() {
  return (
    <>
    <ScrollToTop />
    <Routes>
      <Route element={<Layout />}>
        <Route index element={<Home />} />
        <Route path="about" element={<About />} />
        <Route path="training" element={<Training />} />
        <Route path="signin" element={<SignIn />} />
        <Route path="account" element={<Account />} />

        <Route path="splicepal" element={<SplicePalProduct />} />
        <Route path="splicepal/privacy" element={<SplicePalPrivacy />} />
        <Route path="splicepal/terms" element={<SplicePalTerms />} />
        <Route path="splicepal/support" element={<SplicePalSupport />} />
        <Route path="splicepal/training" element={<SplicePalTraining />} />
        <Route path="splicepal/training/:certLevel" element={<SplicePalModules />} />
        <Route path="splicepal/training/sr" element={<SplicePalSR />} />
        <Route path="splicepal/training/:certLevel/readiness" element={<SplicePalReadiness />} />
        <Route path="splicepal/training/:certLevel/exam" element={<SplicePalExam />} />
        <Route path="splicepal/training/:certLevel/exam/run" element={<SplicePalExamRun />} />
        <Route path="splicepal/training/:certLevel/:moduleId" element={<SplicePalModule />} />

        <Route path="weldpal" element={<WeldPalProduct />} />
        <Route path="weldpal/privacy" element={<WeldPalPrivacy />} />
        <Route path="weldpal/terms" element={<WeldPalTerms />} />
        <Route path="weldpal/support" element={<WeldPalSupport />} />
        <Route path="weldpal/training" element={<WeldPalTraining />} />
        <Route path="weldpal/training/sr" element={<WeldPalSR />} />
        <Route path="weldpal/training/:certLevel/readiness" element={<WeldPalReadiness />} />
        <Route path="weldpal/training/:certLevel/exam" element={<WeldPalExam />} />
        <Route path="weldpal/training/:certLevel/exam/run" element={<WeldPalExamRun />} />
        <Route path="weldpal/training/:certLevel" element={<WeldPalModules />} />
        <Route path="weldpal/training/:certLevel/:moduleId" element={<WeldPalModule />} />

        <Route path="poolpal" element={<PoolPalProduct />} />
        <Route path="poolpal/privacy" element={<PoolPalPrivacy />} />
        <Route path="poolpal/terms" element={<PoolPalTerms />} />
        <Route path="poolpal/support" element={<PoolPalSupport />} />

        <Route path="voltpal" element={<VoltPalProduct />} />
        <Route path="voltpal/privacy" element={<VoltPalPrivacy />} />
        <Route path="voltpal/terms" element={<VoltPalTerms />} />
        <Route path="voltpal/support" element={<VoltPalSupport />} />
        <Route path="voltpal/training" element={<VoltPalTraining />} />
        <Route path="voltpal/training/:slug" element={<VoltPalArticle />} />

        <Route path="pipepal" element={<PipePalProduct />} />
        <Route path="pipepal/privacy" element={<PipePalPrivacy />} />
        <Route path="pipepal/terms" element={<PipePalTerms />} />
        <Route path="pipepal/support" element={<PipePalSupport />} />
        <Route path="pipepal/training" element={<PipePalTraining />} />
        <Route path="pipepal/training/:slug" element={<PipePalArticle />} />

        <Route path="*" element={<NotFound />} />
      </Route>
    </Routes>
    </>
  )
}
