import { Routes, Route, useLocation } from 'react-router-dom'
import { useEffect } from 'react'
import Layout from './components/Layout'
import Home from './pages/Home'
import About from './pages/About'
import AdminDashboard from './pages/admin/Dashboard'
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
import PoolPalProduct from './pages/poolpal/Product'
import PoolPalPrivacy from './pages/poolpal/Privacy'
import PoolPalTerms from './pages/poolpal/Terms'
import PoolPalSupport from './pages/poolpal/Support'
import PoolPalTraining from './pages/poolpal/TrainingIndex'
import PoolPalModules from './pages/poolpal/TrainingModules'
import PoolPalModule from './pages/poolpal/TrainingModule'
import PoolPalExam from './pages/poolpal/TrainingExam'
import PoolPalExamRun from './pages/poolpal/TrainingExamRun'
import PoolPalReadiness from './pages/poolpal/TrainingReadiness'
import PoolPalSR from './pages/poolpal/TrainingSR'
import VoltPalProduct from './pages/voltpal/Product'
import VoltPalPrivacy from './pages/voltpal/Privacy'
import VoltPalTerms from './pages/voltpal/Terms'
import VoltPalSupport from './pages/voltpal/Support'
import VoltPalTraining from './pages/voltpal/TrainingIndex'
import VoltPalModules from './pages/voltpal/TrainingModules'
import VoltPalModule from './pages/voltpal/TrainingModule'
import VoltPalExam from './pages/voltpal/TrainingExam'
import VoltPalExamRun from './pages/voltpal/TrainingExamRun'
import VoltPalReadiness from './pages/voltpal/TrainingReadiness'
import VoltPalSR from './pages/voltpal/TrainingSR'
import WindPalProduct from './pages/windpal/Product'
import WindPalPrivacy from './pages/windpal/Privacy'
import WindPalTerms from './pages/windpal/Terms'
import WindPalSupport from './pages/windpal/Support'
import WindPalTraining from './pages/windpal/TrainingIndex'
import WindPalModules from './pages/windpal/TrainingModules'
import WindPalModule from './pages/windpal/TrainingModule'
import WindPalExam from './pages/windpal/TrainingExam'
import WindPalExamRun from './pages/windpal/TrainingExamRun'
import WindPalReadiness from './pages/windpal/TrainingReadiness'
import WindPalSR from './pages/windpal/TrainingSR'
import LiftPalProduct from './pages/liftpal/Product'
import LiftPalPrivacy from './pages/liftpal/Privacy'
import LiftPalTerms from './pages/liftpal/Terms'
import LiftPalSupport from './pages/liftpal/Support'
import LiftPalTraining from './pages/liftpal/TrainingIndex'
import LiftPalModules from './pages/liftpal/TrainingModules'
import LiftPalModule from './pages/liftpal/TrainingModule'
import LiftPalExam from './pages/liftpal/TrainingExam'
import LiftPalExamRun from './pages/liftpal/TrainingExamRun'
import LiftPalReadiness from './pages/liftpal/TrainingReadiness'
import LiftPalSR from './pages/liftpal/TrainingSR'
import PipePalProduct from './pages/pipepal/Product'
import PipePalPrivacy from './pages/pipepal/Privacy'
import PipePalTerms from './pages/pipepal/Terms'
import PipePalSupport from './pages/pipepal/Support'
import PipePalTraining from './pages/pipepal/TrainingIndex'
import PipePalModules from './pages/pipepal/TrainingModules'
import PipePalModule from './pages/pipepal/TrainingModule'
import PipePalExam from './pages/pipepal/TrainingExam'
import PipePalExamRun from './pages/pipepal/TrainingExamRun'
import PipePalReadiness from './pages/pipepal/TrainingReadiness'
import PipePalSR from './pages/pipepal/TrainingSR'

function ScrollToTop() {
  const { pathname, hash } = useLocation()
  useEffect(() => {
    if (hash) {
      const el = document.getElementById(hash.slice(1))
      if (el) { el.scrollIntoView({ behavior: 'smooth' }); return }
    }
    window.scrollTo(0, 0)
  }, [pathname, hash])
  return null
}

export default function App() {
  return (
    <>
    <ScrollToTop />
    <Routes>
      <Route path="/admin" element={<AdminDashboard />} />
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
        <Route path="splicepal/training/sr" element={<SplicePalSR />} />
        <Route path="splicepal/training/:certLevel" element={<SplicePalModules />} />
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
        <Route path="poolpal/training" element={<PoolPalTraining />} />
        <Route path="poolpal/training/sr" element={<PoolPalSR />} />
        <Route path="poolpal/training/:certLevel/readiness" element={<PoolPalReadiness />} />
        <Route path="poolpal/training/:certLevel/exam" element={<PoolPalExam />} />
        <Route path="poolpal/training/:certLevel/exam/run" element={<PoolPalExamRun />} />
        <Route path="poolpal/training/:certLevel" element={<PoolPalModules />} />
        <Route path="poolpal/training/:certLevel/:moduleId" element={<PoolPalModule />} />

        <Route path="voltpal" element={<VoltPalProduct />} />
        <Route path="voltpal/privacy" element={<VoltPalPrivacy />} />
        <Route path="voltpal/terms" element={<VoltPalTerms />} />
        <Route path="voltpal/support" element={<VoltPalSupport />} />
        <Route path="voltpal/training" element={<VoltPalTraining />} />
        <Route path="voltpal/training/sr" element={<VoltPalSR />} />
        <Route path="voltpal/training/:certLevel/readiness" element={<VoltPalReadiness />} />
        <Route path="voltpal/training/:certLevel/exam" element={<VoltPalExam />} />
        <Route path="voltpal/training/:certLevel/exam/run" element={<VoltPalExamRun />} />
        <Route path="voltpal/training/:certLevel" element={<VoltPalModules />} />
        <Route path="voltpal/training/:certLevel/:moduleId" element={<VoltPalModule />} />

        <Route path="pipepal" element={<PipePalProduct />} />
        <Route path="pipepal/privacy" element={<PipePalPrivacy />} />
        <Route path="pipepal/terms" element={<PipePalTerms />} />
        <Route path="pipepal/support" element={<PipePalSupport />} />
        <Route path="pipepal/training" element={<PipePalTraining />} />
        <Route path="pipepal/training/sr" element={<PipePalSR />} />
        <Route path="pipepal/training/:certLevel/readiness" element={<PipePalReadiness />} />
        <Route path="pipepal/training/:certLevel/exam" element={<PipePalExam />} />
        <Route path="pipepal/training/:certLevel/exam/run" element={<PipePalExamRun />} />
        <Route path="pipepal/training/:certLevel" element={<PipePalModules />} />
        <Route path="pipepal/training/:certLevel/:moduleId" element={<PipePalModule />} />

        <Route path="windpal" element={<WindPalProduct />} />
        <Route path="windpal/privacy" element={<WindPalPrivacy />} />
        <Route path="windpal/terms" element={<WindPalTerms />} />
        <Route path="windpal/support" element={<WindPalSupport />} />
        <Route path="windpal/training" element={<WindPalTraining />} />
        <Route path="windpal/training/sr" element={<WindPalSR />} />
        <Route path="windpal/training/:certLevel/readiness" element={<WindPalReadiness />} />
        <Route path="windpal/training/:certLevel/exam" element={<WindPalExam />} />
        <Route path="windpal/training/:certLevel/exam/run" element={<WindPalExamRun />} />
        <Route path="windpal/training/:certLevel" element={<WindPalModules />} />
        <Route path="windpal/training/:certLevel/:moduleId" element={<WindPalModule />} />

        <Route path="liftpal" element={<LiftPalProduct />} />
        <Route path="liftpal/privacy" element={<LiftPalPrivacy />} />
        <Route path="liftpal/terms" element={<LiftPalTerms />} />
        <Route path="liftpal/support" element={<LiftPalSupport />} />
        <Route path="liftpal/training" element={<LiftPalTraining />} />
        <Route path="liftpal/training/sr" element={<LiftPalSR />} />
        <Route path="liftpal/training/:certLevel/readiness" element={<LiftPalReadiness />} />
        <Route path="liftpal/training/:certLevel/exam" element={<LiftPalExam />} />
        <Route path="liftpal/training/:certLevel/exam/run" element={<LiftPalExamRun />} />
        <Route path="liftpal/training/:certLevel" element={<LiftPalModules />} />
        <Route path="liftpal/training/:certLevel/:moduleId" element={<LiftPalModule />} />

        <Route path="*" element={<NotFound />} />
      </Route>
    </Routes>
    </>
  )
}
