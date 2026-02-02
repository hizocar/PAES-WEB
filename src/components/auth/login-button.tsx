"use client"

import { Button } from "@/components/ui/button"
import { useAuth } from "@/context/auth-provider"
import { ComponentProps } from "react"
import { Loader2 } from "lucide-react"

import { useRouter } from "next/navigation"

type LoginButtonProps = ComponentProps<typeof Button> & {
    children: React.ReactNode
}

export function LoginButton({ children, className, ...props }: LoginButtonProps) {
    const { loading } = useAuth()
    const router = useRouter()

    const handleLogin = () => {
        router.push("/login")
    }

    return (
        <Button
            onClick={handleLogin}
            disabled={loading}
            className={className}
            {...props}
        >
            {children}
        </Button>
    )
}

type LoginTriggerProps = React.HTMLAttributes<HTMLDivElement> & {
    children: React.ReactNode
}

export function LoginTrigger({ children, className, ...props }: LoginTriggerProps) {
    const { loading } = useAuth()
    const router = useRouter()

    const handleLogin = () => {
        if (loading) return
        router.push("/login")
    }

    return (
        <div
            onClick={handleLogin}
            className={`${className} ${loading ? 'opacity-50 cursor-wait' : 'cursor-pointer'}`}
            {...props}
        >
            {children}
        </div>
    )
}
