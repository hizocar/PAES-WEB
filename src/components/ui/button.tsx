import { ButtonHTMLAttributes, forwardRef } from "react"
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs))
}

export interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
    variant?: "default" | "outline" | "ghost" | "secondary"
    size?: "default" | "sm" | "lg"
}

const Button = forwardRef<HTMLButtonElement, ButtonProps>(
    ({ className, variant = "default", size = "default", ...props }, ref) => {
        return (
            <button
                ref={ref}
                className={cn(
                    "cursor-pointer inline-flex items-center justify-center rounded-xl font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50",
                    {
                        "bg-blue-600 text-white hover:bg-blue-700 shadow-lg shadow-blue-500/30": variant === "default",
                        "border border-slate-200 bg-white hover:bg-slate-100 text-slate-900": variant === "outline",
                        "hover:bg-slate-100 text-slate-700": variant === "ghost",
                        "bg-slate-100 text-slate-900 hover:bg-slate-200": variant === "secondary",
                        "h-10 px-4 py-2": size === "default",
                        "h-9 px-3 text-sm": size === "sm",
                        "h-12 px-8 text-lg": size === "lg",
                    },
                    className
                )}
                {...props}
            />
        )
    }
)
Button.displayName = "Button"

export { Button }
