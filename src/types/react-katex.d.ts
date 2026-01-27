declare module 'react-katex' {
    import { ComponentType } from 'react';
    const Latex: ComponentType<{ children: string; block?: boolean }>;
    export default Latex;
}
