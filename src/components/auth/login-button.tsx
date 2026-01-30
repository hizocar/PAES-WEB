"use client"

import { Button } from "@/components/ui/button"
import { useAuth } from "@/context/auth-provider"
import { ComponentProps } from "react"
import { Loader2 } from "lucide-react"

type LoginButtonProps = ComponentProps<typeof Button> & {
    children: React.ReactNode
}

export function LoginButton({ children, className, ...props }: LoginButtonProps) {
    const { signInWithGoogle, loading } = useAuth()

    const handleLogin = async () => {
        await signInWithGoogle()
    }

    return (
        <Button
            onClick={handleLogin}
            disabled={loading}
            className={className}
            {...props}
        >
            {loading ? <Loader2 className="mr-2 h-4 w-4 animate-spin" /> : null}
            {children}
        </Button>
    )
}

type LoginTriggerProps = React.HTMLAttributes<HTMLDivElement> & {
    children: React.ReactNode
}

export function LoginTrigger({ children, className, ...props }: LoginTriggerProps) {
    const { signInWithGoogle, loading } = useAuth()

    const handleLogin = async () => {
        if (loading) return
        await signInWithGoogle()
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
