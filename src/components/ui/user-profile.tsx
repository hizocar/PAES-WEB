"use client"

import {
    Avatar,
    AvatarFallback,
    AvatarImage,
} from "@/components/ui/avatar"

type UserProfileProps = {
    user: {
        email?: string
        user_metadata: {
            full_name?: string
            avatar_url?: string
        }
    }
}

export function UserProfile({ user }: UserProfileProps) {
    const initials = user.user_metadata.full_name
        ? user.user_metadata.full_name.split(" ").map((n) => n[0]).join("").substring(0, 2).toUpperCase()
        : user.email?.charAt(0).toUpperCase() || "?"

    return (
        <div className="flex items-center gap-3 mb-3 px-1">
            <Avatar className="w-12 h-12 border-2 border-slate-200">
                <AvatarImage src={user.user_metadata.avatar_url} alt={user.user_metadata.full_name || "User"} />
                <AvatarFallback className="bg-slate-100 text-slate-600 font-bold text-lg">
                    {initials}
                </AvatarFallback>
            </Avatar>
            <div className="flex-1 overflow-hidden">
                <p className="text-lg font-bold text-slate-900 truncate">
                    {user.user_metadata.full_name || 'Estudiante'}
                </p>
                <p className="text-xs text-slate-500 truncate" title={user.email}>{user.email}</p>
            </div>
        </div>
    )
}
