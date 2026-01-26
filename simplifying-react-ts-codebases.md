# Simplifying React + TypeScript Codebases: A

# Comprehensive Guide

## Principles for Simplifying React + TypeScript Code

In a React/TypeScript codebase, simplicity comes from clear structure, minimal extra “plumbing” code, and
strong typing that prevents mistakes. Below are key principles (with mini examples) to reduce accidental
complexity, improve readability, and make code safer to change:

### 1. Single-Responsibility Components

**When it applies:** Always favor components that do one thing well. If a component is managing data
fetching, state, **and** complex UI all at once, it violates single-responsibility and becomes hard to test or
reuse.

**Bad Example:** A monolithic component handling form UI _and_ data submission logic:

```
functionUserFormPage() {
// Too many responsibilities in one component
const[formData, setFormData] = useState({...});
const[error, setError] = useState(null);
const[saved, setSaved] = useState(false);
```
```
consthandleSubmit= async() => {
// form validation logic...
try {
await api.saveUser(formData); // also doing data API call here
setSaved(true);
} catch (e) { setError(e); }
};
```
```
return(
<div>
{/* form fields using formData and handleSubmit */}
{error && <ErrorDisplay error={error} />}
{saved && <SuccessNotice/>}
</div>
);
}
```
```
1
```
```
1
```

**Good Example:** Split the data-handling into a custom hook (useSaveUser) and keep the component for
UI:

```
functionuseSaveUser() {
const[error, setError] = useState<Error | null>(null);
const[saved, setSaved] = useState(false);
constsaveUser =async (data: UserData) => {
try {
await api.saveUser(data);
setSaved(true);
} catch (e) { setError(eas Error); }
};
return{ saveUser, error, saved};
}
```
```
functionUserFormPage() {
const{ saveUser, error, saved} = useSaveUser();
// UI uses saveUser action from hook
return(
<Form onSubmit={saveUser}>
{/* form fields */}
{error && <ErrorDisplay error={error} />}
{saved && <SuccessNotice/>}
</Form>
);
}
```
Now UserFormPage is focused on rendering, and useSaveUser handles side-effects. This adheres to
SRP, making each piece easier to test and reuse.

**Trade-offs:** Too many tiny components/hooks can increase indirection. Don’t split a component so far that
its logic becomes hard to follow due to constant jumping between files. Aim for logical boundaries:
separate when a portion of the code could change independently or be reused.

### 2. State Colocation (Localize State Where Used)

**When it applies:** Use local component state or context **closest** to where state is needed, rather than
hoisting everything to a global store. This reduces prop drilling and keeps components self-
contained.

**Bad Example:** Putting all state in a Redux store or top context that doesn’t need to be global:

```
// Over-hoisted state: even simple local UI state is in a global store
constinitialState= { modalOpen:false, inputValue: ""};
functionuiReducer(state = initialState, action) {/* ... */}
```
```
1
```
```
2 3
```
```
4 5
```

```
// In component:
constmodalOpen= useSelector(state => state.ui.modalOpen);
```
**Good Example:** Use useState in the component (or context at a section level) for purely local concerns:

```
functionSettingsModal() {
// Keep state local since it's only used here
const[isOpen, setOpen] = useState(false);
return(
<>
<buttononClick={()=> setOpen(true)}>OpenSettings</button>
{isOpen&& <ModalContent onClose={()=> setOpen(false)} />}
</>
);
}
```
If multiple sibling components need shared state, lift it to their nearest common parent _instead of_ a global
store. For truly global data (current user, theme, etc.), use a dedicated context provider at the app root –
but don't stuff unrelated things into one context (avoid **context bloat** where a context provides far more
than each consumer needs). As Kent C. Dodds advises: “Keep state as local as possible and use context only
when prop drilling really becomes a problem.”

**Trade-offs:** Colocating state minimizes unnecessary re-renders (only descendents re-render) and makes
components more independent. The pitfall is _duplicating_ state – if two distant parts of the app need to
sync, lifting to context or a store is appropriate. Always ask: does this state truly need to be global? If not,
keep it local for simplicity.

### 3. Limit Prop Drilling via Composition or Context

**When it applies:** Passing props down many levels (prop drilling) can cause deeply nested component trees
and boilerplate. If a value is needed far down and especially by many components, consider React Context
or rearrange the component structure to pass fewer layers.

**Bad Example:** Three levels of prop drilling:

```
<App>
<PagecurrentUser={user}> {/* passes prop down */}
<Toolbar currentUser={user}> {/* passes again */}
<UserMenucurrentUser={user}/> {/* finally uses prop */}
</Toolbar>
</Page>
</App>
```
```
6
```
```
7
```
```
4
```

**Good Example 1 (Composition):** Skip levels by composing components:

```
functionPage({ children }) {
// Page doesn't need currentUser itself, so no prop for it
return<div>{children}</div>;
}
```
```
functionApp() {
return(
<Page>
{/* Provide UserMenu directly where needed */}
<Toolbar>
<UserMenucurrentUser={user} />
</Toolbar>
</Page>
);
}
```
**Good Example 2 (Context):** Use Context API to provide a value to deeply nested children:

```
constCurrentUserContext = createContext<User | null>(null);
```
```
functionApp() {
return(
<CurrentUserContext.Providervalue={user}>
<Page/>
</CurrentUserContext.Provider>
);
}
```
```
// Deep inside:
functionUserMenu() {
constcurrentUser = useContext(CurrentUserContext); // accessible anywhere
below Provider
return<span>Welcome, {currentUser?.name}</span>;
}
```
By using context, intermediate components no longer need to accept and pass along currentUser. This
reduces “prop drilling” boilerplate.

**Trade-offs:** _Prop drilling itself is not evil_ – it’s straightforward and has zero additional API surface. In
fact, passing props keeps data flow explicit and predictable. Use context **sparingly** : it introduces implicit
dependencies (components reading from invisible sources of data) and can make tracking data flow harder
during debugging. A good rule of thumb: if you’re passing a prop through more than 2-3 layers _purely_ to

```
8
```
```
9 10
11
```
```
11
```

get it to a distant consumer (and intermediate layers don’t really use it), that’s a candidate for Context or a
different component structure. Otherwise, plain props are fine and add no extra complexity. Always
weigh the cost of an extra context (and its potential for unwanted re-renders) against a bit of prop
plumbing.

### 4. Prefer Composition Over Conditionals or Inheritance

**When it applies:** Instead of writing giant components with lots of conditional branches or using class
inheritance for variations, compose components together. React’s composition model lets you swap or
extend behavior by combining components, which is often simpler than many if/else in one place
.

**Bad Example:** A single component with conditional rendering for multiple variants:

```
functionNotification({type, message}) {
// Too much conditional logic inside
if(type=== 'error') {
return <divclassName="alert error">{message}</div>;
}elseif (type=== 'warning') {
return <divclassName="alert warning">{message}</div>;
}
return<divclassName="alert info">{message}</div>;
}
```
**Good Example:** Separate components for each variant and compose or choose them in the parent:

```
functionErrorAlert({ message }: { message:string }) {
return<divclassName="alert error">{message}</div>;
}
functionWarningAlert({ message }: { message: string }) {
return<divclassName="alert warning">{message}</div>;
}
functionInfoAlert({ message}: { message: string }) {
return<divclassName="alert info">{message}</div>;
}
```
```
// Parent decides which to use:
constAlert = ({type, message}) => {
switch(type) {
case'error': return <ErrorAlertmessage={message} />;
case'warning': return <WarningAlertmessage={message} />;
default: return <InfoAlertmessage={message} />;
}
};
```
```
9
```
```
12
13
```

Now each component (ErrorAlert, etc.) is simpler and focused. The parent Alert acts as a factory or
chooser. This adheres to the Open/Closed Principle: the Alert component is open to extension (we can
add new alert types easily by adding a new component and case) but closed for modification (no need to
rewrite internal logic of one big function).

**Trade-offs:** More components means more files and more component boundaries – ensure each variant
isn’t _too trivial_ to justify its own component. (If the only difference is a small text or style, props might suffice
rather than separate components.) Composition shines when each piece has distinct internal logic or can be
developed in isolation. Avoid deep inheritance hierarchies or excessive wrapper components (e.g., wrapping
a button in 5 context providers for trivial concerns) – that’s over-abstraction that adds little value. Prefer
**composable props** (pass a component or function as a prop) or children to inject behavior, instead of
building monolithic components that handle every scenario.

### 5. Encapsulate Reusable Logic in Custom Hooks

**When it applies:** Whenever multiple components share logic (data fetching, complex state management,
timers, etc.), or a component’s logic is getting bulky, consider extracting a custom hook. Hooks let you reuse
stateful logic without duplicating code in each component , and they hide implementation details
behind a simple interface (the returned state/actions).

**Bad Example:** Duplicate data fetching logic in two components:

```
functionPosts() {
const[posts, setPosts] = useState<Post[] | null>(null);
useEffect(() => { fetch('/api/posts').then(r => r.json()).then(setPosts); },
[]);
// render posts...
}
functionUsers() {
const[users, setUsers] = useState<User[] | null>(null);
useEffect(() => { fetch('/api/users').then(r => r.json()).then(setUsers); },
[]);
// render users...
}
```
**Good Example:** A custom hook to fetch any endpoint, used by both components:

```
functionuseData<T>(url: string) {
const[data, setData] = useState<T | null>(null);
const[error, setError] = useState<Error | null>(null);
useEffect(() => {
let cancel = false;
(async() => {
try {
constres = awaitfetch(url);
```
```
14 13
```
```
15
```
```
16 17
```

```
if(!cancel) setData(await res.json());
} catch(err) {
if(!cancel) setError(erras Error);
}
})();
return () => { cancel= true}; // cleanup to avoid state update after
unmount
}, [url]);
return{ data, error};
}
```
```
functionPosts() {
const{ data: posts, error} = useData<Post[]>('/api/posts');
// use posts or show error...
}
functionUsers() {
const{ data: users } = useData<User[]>('/api/users');
// use users...
}
```
Now useData handles the generic fetch logic. This reduces duplication and makes it easier to handle
concerns like cancellation in one place. As another example, splitting a complex component’s logic into one
or more hooks can greatly improve readability. The UI component just “calls” the hook and receives
state, without needing to know how the hook works internally.

**Trade-offs:Don’t create hooks for one-off logic** unless it genuinely improves clarity. There’s debate: some
teams extract almost all logic into hooks so that components are just JSX (render) calls. This can
compartmentalize logic, but if every component has a unique hook, you may be adding indirection with no
reuse. A good heuristic: if logic is used in multiple places or is complex enough to merit isolated
testing, use a hook. If it’s tightly coupled to one component and not overly large, keeping it in the
component might be simpler. Also consider plain functions versus hooks: if logic doesn't need React
state or lifecycle, a plain utility function may suffice (e.g., a pure formatting function doesn’t need to be a
hook).

Custom hooks should also follow SRP: each hook should have a clear purpose (e.g., useForm, useAuth,
useFeatureXData). Avoid “mega” hooks that do too much; they become hard to maintain. **Pitfall:** Too
many layers of custom hooks (hooks calling hooks calling hooks) can complicate the mental model and
debugging (stack traces become longer). Use custom hooks where they reduce overall complexity, not just
to follow a trend.

### 6. Make Component Interfaces (Props) Minimal and Meaningful

**When it applies:** The props of a component define its public API. Simplify interfaces to only what the
component truly needs. Fewer, well-named props make components easier to understand and use, and
limit coupling.

```
17 18
19 20
```
```
21 22
23
2 3
```

**Bad Example:** A component that takes a dozen props, many optional or related:

```
functionDataTable(props: {
data?:any[];isRemote?: boolean; fetchUrl?: string;
showFooter?: boolean; footerText?: string; /* ...more props... */
}) {
// ... huge component ...
}
```
This DataTable tries to handle both local data and remote fetching (notice data vs fetchUrl),
optional footer display, and more – all in one interface. Callers must understand many props and
combinations (likely violating _Interface Segregation Principle_ since most usage scenarios won’t need all
props).

**Good Example:** Split into focused interfaces or use composition for extensibility:

```
interfaceLocalDataTableProps{ data: Item[];}
interfaceRemoteDataTableProps{ fetchUrl: string; }
// Two separate variants for clarity
```
```
functionDataTable(props: LocalDataTableProps| RemoteDataTableProps) {
if('fetchUrl' inprops) {
// remote variant
const { data, error} = useData(props.fetchUrl);
if (error) return <ErrorViewerror={error}/>;
return data? <Table rows={data}/>: <Spinner/>;
}else{
// local variant
return <Table rows={props.data}/>;
}
}
```
```
// Footer can be a child or separate composition:
functionDataTableWithFooter({ footer, ...tableProps}: { footer: ReactNode} &
(LocalDataTableProps| RemoteDataTableProps)) {
return(
<div>
<DataTable {...tableProps} />
<footer>{footer}</footer>
</div>
);
}
```
```
24 25
```

In this example, we use a **discriminated union** for props: if fetchUrl is provided, we treat it as a remote
data table, otherwise it requires data. This makes invalid combinations impossible at the type level (TS
will enforce that either data or fetchUrl is given, not neither or both). It also splits the logic internally
for clarity. Additional features like a footer are handled via composition (wrapping in another component)
or by passing React elements as children/props, rather than bloating the DataTable component itself
with too many booleans and text props.

**Trade-offs:** A lean prop interface strengthens component boundaries – the component does one job
because it only has the inputs for that job. Aim for **cohesive props** : if you find a component has many props
that often vary together, consider grouping them into an object or context (e.g., a complex filter criteria
passed as one object prop instead of 10 separate filter props). But be careful: grouping too much can
reduce clarity (the consumer might need to construct that object). Striking a balance is key. Also, prefer
semantic prop names (e.g., use isDisabled instead of disabledFlag) and consistent conventions like
prefix boolean props with is/has/should for readability.

**Red flag:** If a component has 15+ props or a single prop that’s a giant object with many fields, that’s a sign
it might be doing too much – consider splitting it into smaller components or hooks (as per SRP).
Keep interfaces focused on what the component actually needs; don’t force consumers to depend on props
they don’t use.

### 7. Leverage TypeScript for Safety, Not Ceremony

**When it applies:** TypeScript should reduce bugs and clarify intent _without_ drowning the code in noise. Use
TS features to make code safer and more self-documenting, but avoid overly verbose type annotations
when they’re not needed.

**Bad Example:** Redundant or overly explicit types that clutter code:

```
constname: string= "Alice"; // type is obvious, adds noise
constscores:Array<number> = [10, 15]; // can be inferred as number[]
functionadd(a: number, b:number):number { // explicit return type here is
fine but not required
returna + b;
}
```
```
interfaceUserProps{
user: User;
}
functionUserCard(props: UserProps) { // could destructure for clarity
return<div>{props.user.name}</div>;
}
```
**Good Example:** Lean on inference for local variables and use explicit types at API boundaries:

```
26
```
```
1 24
```
```
24
```

```
constname= "Alice"; // string inferred
constscores = [10, 15]; // number[] inferred
```
```
functionadd(a: number, b:number) {
returna + b; // return type inferred as number
}
```
```
interfaceUserProps{
user: User;
}
functionUserCard({ user}: UserProps) { // Destructure props for clarity
return<div>{user.name}</div>;
}
```
In functions and components, you often don’t need to annotate return types – TS will infer them (though
feel free to add if it aids clarity or for complex generics). Save explicit annotations for module boundaries:
exported functions, component props, context values, etc., where you want the contract clearly declared

. This approach is summed up by a community guideline: “Explicit types are for boundaries and
contracts. Inside your implementation, let TypeScript do its job.”

Also, use **union types and enums** to your advantage. For example, instead of passing a string “mode” prop
with expected values "light" or "dark", define type ThemeMode = 'light' | 'dark'; – now if
someone passes an unsupported value, TS will catch it. Use **discriminated unions** for UI states to avoid
impossible combinations. For instance:

```
typeLoadingState= { status: 'loading'};
typeSuccessState= { status: 'success'; data: Data};
typeErrorState = { status: 'error'; error: Error };
typeDataState= LoadingState| SuccessState| ErrorState;
```
A component can use DataState so that it _must_ handle all cases of status (TS will enforce exhaustive
checks), rather than juggling separate isLoading/error flags that might be mismanaged.

**Trade-offs:** Using TS effectively greatly reduces runtime bugs and makes refactoring safer – if you change a
prop type, all incorrect usages break at compile time (much easier to fix than chasing runtime errors).
However, beware of **over-engineering types** – e.g., using complex conditional types or generics for a
simple case can confuse future maintainers. A classic overkill is writing a generic type for every component
“just in case” it will be reused in different ways. As a Shopify engineering guide notes, adding
generics everywhere or highly abstract types “even on components unlikely to be reused” is usually more
complexity than it’s worth. Start with simple, concrete types; introduce generics or advanced types only
when a real need arises (YAGNI principle for types).

Finally, **avoid any** whenever possible – it defeats the purpose of TS. If you truly have an unknown type
(e.g., data from a JSON blob), use unknown and then narrow it with type guards or validation. Use

```
27
27
```
```
28 29
```
```
29
```

interface or type consistently for object shapes (both are fine; many use type for React props for
flexibility). The key is to make types work for you (catching errors, improving IDE autocomplete) without
turning your code into a verbose type puzzle. Good TypeScript _simplifies_ understanding of the code by
making contracts explicit and highlighting improper usage at compile time.

### 8. Avoid Accidental Complexity (YAGNI and KISS)

**When it applies:** Always be on guard for “overengineering” – adding complexity without concrete benefit.
Follow YAGNI (“You Aren’t Gonna Need It”) – implement for today’s requirements, not hypothetical future
ones. And KISS (“Keep It Simple, Stupid”) – simpler code is easier to maintain.

**Bad Example:** Premature abstraction and features: - Creating an elaborate plugin system “just in case”
future modules need it, when only one module exists. - Using a state management library like Redux or an
event emitter for a few bits of state that useState or simple context could handle. - Writing your own
data fetching/cache layer instead of using a well-tested library or simpler built-in approach. - Deeply
nested component hierarchies with multiple levels of HOCs providing things like logging, theming, analytics
wrappers around every component (seen in some over-engineered apps).

These add _accidental complexity_ – extra structure that isn’t inherently required by the problem.

**Good Example:** Start with the simplest thing that works: - Use React’s own state and context for state
management until proven insufficient (e.g., scale up to Redux/Zustand **only** if the app truly needs cross-
component state with sophisticated updates or debugging tools). - Fetch data with fetch/axios in a
useEffect or use a lightweight utility; introduce a caching library (React Query, etc.) when data
interactions grow complex or performance demands caching. - Build components for current needs. If a
button is only ever used one way, don’t generalize it into a “GenericButtonFactory” with tons of options. It’s
fine to duplicate a bit of code now if you’re not sure how it should abstract – “sometimes duplication is
actually cheaper than the wrong abstraction”. You can refactor common patterns later when they
emerge with clearer shape.

In practice, this means regularly questioning: “Is this the simplest way to achieve the functionality? Am I
adding knobs and switches no one uses yet?” For example, don’t introduce SSR (Next.js, etc.) unless you
need server rendering for SEO or performance. Don’t incorporate a complex form library for a simple
contact form – maybe controlled components or a small custom hook suffice.

**Trade-offs:** The benefit of avoiding accidental complexity is faster development and easier onboarding (new
devs won’t be lost in needless abstractions ). The risk is that you might need to refactor when
requirements grow – but that’s okay, because your code will be simpler to refactor without layers of
indirection. Always leave room to extend (e.g., design components to be composable and configurable via
props – that’s the Open/Closed principle in action ), but don’t build elaborate extension points until
they’re needed. Modern React makes it relatively easy to iterate and refactor; lean on that flexibility. As a
rule, prefer incremental improvements over big upfront designs: _refactor over rewrite_ and evolve the code as
requirements become clear.

```
30
```
```
31
29
```
```
15
```
```
32
```
```
29
```
```
33
34
```
```
35
```
```
36
```
```
14
30
```
```
37
```

### 9. Favor Readability over Cleverness

**When it applies:** In all code, but especially UI code. Future maintainers (or even future you) should easily
grasp what the code is doing. Prefer clear, straightforward code to “smart” one-liners or micro-
optimizations.

**Bad Example:** Highly terse or clever code that saves a few lines at the cost of clarity:

```
// Using array logic to avoid if/else, but this is hard to parse quickly:
return [
condition&& <SpecialCasekey="special"{...props}/>,
...items.map(i => <Itemkey={i.id} data={i}/>),
showExtra? <Extrakey="extra"/> :null
];
```
This tries to assemble an array of JSX with conditional inclusion. While valid, it mixes multiple concerns in
one return and relies on truthy-falsy tricks. It’s not immediately obvious what the rendered output is.

**Good Example:** Be explicit and clear in JSX:

#### <>

```
{condition&& <SpecialCase{...props} />}
{items.map(i => <Itemkey={i.id} data={i} />)}
{showExtra&& <Extra/>}
</>
```
This uses plain JSX with familiar patterns (condition && ...). It may be a couple more lines, but it’s
obvious what’s happening. Another example: prefer a few well-named intermediate variables over a single
monstrous expression:

```
// Too clever:
constoutput = Object.fromEntries(Object.entries(inputObject).filter(([k,v]) =>
k.startsWith(prefix)));
```
```
// Clearer:
constentries= Object.entries(inputObject);
constfiltered = entries.filter(([key]) => key.startsWith(prefix));
constoutput = Object.fromEntries(filtered);
```
The clear version is easier to debug or modify (e.g., if you need to log something in between).

In React specifically, _JSX readability_ matters. Don’t nest ternaries deeply in JSX – if logic is complex, pull it out
into if statements above the return, or into subcomponents (e.g., a <EmptyState/> component vs
inline ternary showing either list or “No items” text). A tip from a UI patterns guide: “move long conditions


out of the JSX” for readability. Similarly, avoid components whose _purpose_ is solely to return null or
conditionally render children – let the parent handle that logic to keep the tree obvious.

**Trade-offs:** Readable code might use a bit more vertical space or explicit steps, but the payoff is
maintainability. Modern bundlers minify code anyway, so there’s no prize for writing the most compact code
in your source. One caveat: readability shouldn’t come at the expense of performance if there’s a known
bottleneck – but in most cases, writing clearly and using React idioms (like keys on lists, avoiding expensive
operations in render) will be sufficient for performance. If you _must_ do something clever for perf,
encapsulate it and comment it. As a team rule, prefer code that any mid-level developer can understand
over code that only “JavaScript ninjas” appreciate. In code reviews, call out overly clever constructs and ask
for simpler alternatives unless a strong justification exists.

### 10. Design with Testing and Errors in Mind

**When it applies:** If code is hard to test or fails badly, it’s hard to maintain. Simplify components by making
them predictable and by handling errors gracefully.

**Good Practice:** Write components as pure functions with predictable outputs given props/state (no hidden
globals or side-effects in render). This makes them easier to unit test or validate via Storybook. For instance,
a form component that has internal state can still be tested by simulating user input and checking the DOM
output – if the component is too entangled (e.g., directly calls window.alert or does navigation on
submit), those side effects complicate tests. Instead, abstract side-effects: e.g., provide a callback prop for
submission so that in tests you can pass a dummy function.

**Good Practice:** Use **Error Boundaries** to catch render-time errors in a subtree and show a fallback UI
instead of crashing the whole app. In TypeScript, you can create an ErrorBoundary component
(usually class-based or using the react-error-boundary library which is TS-ready ). This ensures that
an error in one component doesn’t bring down the entire page, improving robustness. For example:

```
<ErrorBoundaryfallback={<ErrorFallback />}>
<UserProfile/> {/* if this throws, ErrorFallback UI shows */}
</ErrorBoundary>
```
The fallback UI can also be typed to accept, say, an error message or error object and display details.
Libraries like react-error-boundary provide a hook (useErrorHandler) to integrate with functional
components, and handle typing of the thrown error for you.

**Good Practice:** Clearly separate _UI state_ vs _server state_ (as K.C. Dodds describes ). UI state (component
open/closed, current input values) is ephemeral and best kept local; server state (data from APIs) might be
managed via context or specialized hooks. Treat server state as a cache – and consider using tools like React
Query for it. This separation makes testing easier (you can mock or stub out server calls in one place)
and reduces the chance that a change in one domain (UI details) unexpectedly affects another (data logic).

**Good Practice:** Provide sensible defaults and fallbacks. For instance, if a component expects a list prop,
consider defaulting it to an empty array (MyComponent.defaultProps = { items: [] } or in TS,

```
38
39 40
```
```
41
42
```
```
43
```
```
44
```
```
45
```

function MyComponent({ items = [] }: Props)) to avoid unnecessary undefined checks. Use
TypeScript’s non-null assertions sparingly; it’s better to actually handle the null/undefined case (either by
not allowing it in the type or by adding a graceful branch).

**Trade-offs:** Sometimes, adding error boundaries or extra checks might seem like more code, but it greatly
simplifies the _operation_ of the app – fewer “white screen” crashes, easier debugging (because errors are
caught and can be logged). Testing considerations might lead you to slightly refactor code (e.g., separate
pure logic from React components so you can unit test it). This upfront effort pays off by enabling safe
refactoring: if you have good tests covering a component’s behavior, you can confidently simplify its
implementation and know if you broke something. It also tends to enforce cleaner separation of concerns
(which loops back to single-responsibility principle).

These principles serve as high-level guides. Next, we delve into concrete refactoring techniques and
patterns to put them into action.

## Refactoring Techniques Catalog

Refactoring is about **improving code structure without changing its behavior**. Below is a catalog of
techniques grouped by category – components, hooks, state/props, typing, architecture, async, and tests.
Each technique includes its intent, how-to steps, a brief example, and when _not_ to use it.

### Component Refactoring Techniques

```
Extract Smaller Components
Intent: Break a large component into smaller ones to isolate complexity and increase reuse. This
addresses components doing “too much” (often identified by many state variables or giant render
JSX).
How-to: Identify parts of the JSX or state that form a logical unit (e.g., a sub-section of UI, or a piece
of state that only interacts with some of the JSX). Cut and paste that JSX into a new component. Pass
in necessary data via props. The IDE will usually show errors for missing variables – those become
the props of the new component. Continue until the parent component is shorter and
higher-level.
Example: In a dashboard component showing a chart and a table, if the table portion with filters is
200 lines, extract <DataTable> as a child component. The parent passes data and filter values
as props. The child handles its own sorting, rendering, etc.
Don’t do it when...: the piece you extract is too tightly coupled to the parent (e.g., relies on many
parent props/state). If you find yourself drilling 5+ props into a child just to extract it, it may not be a
clean boundary – you might instead consider a context for those, or keep it together. Also avoid over-
splitting (e.g., splitting a simple form into separate components for each field might be overkill
unless those fields are complex or reused). Use extraction to isolate meaningful units (the “seams”
where splitting makes sense ).
```
```
Flatten Conditional Rendering
Intent: Simplify JSX that has complex conditional logic by restructuring it or moving logic out. Deeply
nested ternaries or <>{ condition? A : B }</> blocks can be hard to read and maintain.
```
#### •

```
46 12
```
```
47 48
```
```
49 50
```
#### •


```
How-to: If you have a large conditional chunk (e.g., if (!user) ... else ... rendering two
big blocks), consider splitting into separate components or functions. For example, create
<LoggedInDashboard> and <GuestDashboard> components and simply choose between them
in the parent. Alternatively, if two conditional branches share a lot of markup, refactor to consolidate
the common parts and only conditionalize the small differences (possibly by computing a value or
choosing a sub-component). For long boolean expressions in JSX, calculate them above the
return:
```
```
constshowSpecial = cond1&& status=== 'bar'|| date=== today;
return <>{ showSpecial&& <Bar/> }</>;
```
```
This uses a well-named constant showSpecial instead of inlining that logic in JSX, per the advice
to move long conditions out.
Example: A form component that renders either a login form or a registration form based on a
mode flag. Instead of:
```
```
return mode==='login'? <LoginForm {...props}/> : <RegisterForm
{...props}/>;
```
```
which is okay but if those forms are big JSX blocks defined inline, it’s messy. Better:
```
```
return <>{mode==='login'? <LoginForm/> : <RegisterForm/>}</>;
```
```
or even:
```
```
return mode==='login'? <LoginForm/> : <RegisterForm/>;
```
```
with each form as its own component. Now each form component is simpler to work with, and the
conditional in the parent is a single line.
Don’t do it when...: the conditional logic is trivial or splitting it would introduce duplicate code
without much benefit. For instance, if only a small piece of UI differs (like an icon or text), you might
just use a conditional inside the component rather than separate components – splitting would be
overkill. Use this technique when conditions create distinct modes or states of the UI that can be
cleanly separated.
```
```
Avoid “Invisible” Wrapper Components
Intent: Reduce unnecessary component layers that only return {children} or null. Each
component in the tree adds to mental overhead and potential performance cost (though minor), so
if a component doesn’t encapsulate any logic or UI of its own, it might not be needed.
How-to: If you have components whose sole job is to decide whether to render children (like if (!
props.show) return null; else return <>{props.children}</>), consider removing
them. Let the parent handle the conditional. For example, instead of:
```
```
51 52
```
```
38
```
#### •


```
<MaybeShowshow={condition}>
<SomeComponent/>
</MaybeShow>
```
```
where MaybeShow is:
```
```
functionMaybeShow({ show, children}) {
if(!show) return null;
return<>{children}</>;
}
```
```
just do {condition && <SomeComponent/>} in the parent. This aligns with the principle: “The
component’s parent decides if the component is rendered or not”. Similarly, if you have a
component only to wrap children in a fragment or div with no additional props, you can often
remove it in favor of fragment shorthand <>.
Example: A AuthGate component that either renders children if the user is logged in or redirects
otherwise. If AuthGate doesn’t do anything besides check context and decide, consider that it’s
actually performing an important function (auth check), so it might be fine. But a component like:
```
```
functionSectionWrapper({ children }) {return <div>{children}</div>; }
```
```
used everywhere is pointless – just use <div> in place.
Don’t do it when...: the wrapper actually encapsulates logic or a shared concern (even if it returns
children). For instance, an ErrorBoundary is invisible in output but crucial in behavior, so you
wouldn’t remove that. Or a context provider component that wraps children is necessary for
providing value. This advice is for wrappers that don’t provide significant value or could be trivially
replaced by JSX syntax.
```
```
Combine Duplicate Components or Branches
Intent: If you find nearly identical code in two components or two branches of conditional logic,
refactor to merge them and parameterize the differences. This reduces duplication and divergence
risk.
How-to: Extract the common parts into a shared component or function. Parameterize differences
via props. For example, if AdminUserList and RegularUserList share 90% code except an
extra column, create one UserList component with a prop showAdminColumns or a render
prop for extra columns. Alternatively, factor the common layout in a base component and extend for
differences (through composition, not inheritance).
Example: Two forms LoginForm and RegisterForm share many fields like email, password, but
one has an extra username field. You could have one AuthForm component that takes a prop
mode: 'login' | 'register' and internal logic to include/exclude the username field, or
better, have AuthForm always include both but for login mode hide the username field. However, if
the forms differ substantially or will evolve differently, keeping them separate might be cleaner – see
Don’t do it when.
Don’t do it when...: the code is superficially similar but might change independently. As the DRY
```
```
39 40
```
#### •


```
principle section noted, don’t force abstraction on things that might diverge. If two components
look similar now but represent different concepts (e.g., UserTable vs ProductTable), you might
keep them separate until a clear pattern emerges to abstract. Over-abstracting too early can lead to
“incomprehensible mazes of abstractions”. So, combine duplicates when it truly reduces
maintenance cost and the result is still understandable (a moderate amount of conditional inside a
unified component might be fine, but if you end up with lots of if (admin) ... else ...
inside, you’ve basically recreated the split internally).
```
```
Presentational vs Container Split
Intent: Separate pure UI from logic/data-fetching by splitting one component into two: a container
(or smart component) that manages state/side-effects, and a presentational (dumb) component
that takes props and renders UI. This is a classic React pattern (especially from Redux days) that still
has relevance, though hooks allow an alternative approach (custom hooks instead of container
components).
How-to: Identify a component that does both data logic and rendering. Move the JSX into a new
presentational component that accepts all needed data via props. The original component becomes
the container that uses hooks or connects to state, then renders the presentational one. If using
Redux, for example, the container might use useSelector/useDispatch then pass props down.
If using hooks, the container calls your custom hooks or does useEffect and passes results down.
Example:
```
```
functionTodoListContainer() {
consttodos= useSelector(selectTodos);
constdispatch = useDispatch();
useEffect(() => { dispatch(fetchTodos()) }, [dispatch]);
constonAdd= text => dispatch(addTodo(text));
return<TodoListtodos={todos} onAddTodo={onAdd} />;
}
```
```
Here TodoList is a presentational component: it renders the list and an add form, invoking
onAddTodo when user submits. TodoListContainer holds the Redux connection logic. In a
hook context:
```
```
functionTodoListContainer() {
const{ todos, addTodo} =
useTodos(); // custom hook providing state and actions
return<TodoListtodos={todos} onAddTodo={addTodo} />;
}
```
```
Don’t do it when...: you already have a clean custom hook separating logic. In modern React, many
teams prefer using hooks to separate concerns rather than container components, to avoid creating
an extra component layer. The container-presentational split can also feel artificial if the
“presentational” component is only used by its container – in that case, it might be simpler to keep
them as one until a need arises to reuse the presentational part. Use this pattern when you foresee
multiple uses of the UI with different data sources, or just to enforce a boundary (which helps testing
```
```
53
```
```
53
```
#### •


```
UI in isolation). If it’s a one-off component, a custom hook for data might achieve the same
separation with fewer files.
```
```
Use Children and Composition Instead of Booleans
Intent: Simplify components that have many boolean props controlling optional content by using
children or composition. Rather than a prop like showHeader={true} toggling some sub-UI,
allow callers to pass in the element if they want it, or use slot-like patterns. This reduces prop count
and makes the component more flexible.
How-to: If a component currently does:
```
```
functionPanel({ title, children, showCloseButton}) {
return<divclassName="panel">
<h3>{title}</h3>
{showCloseButton && <button>X</button>}
<div>{children}</div>
</div>;
}
```
```
Instead, consider:
```
```
functionPanel({ title, children, extraHeaderContent}) {
return<divclassName="panel">
<divclassName="panel-header">
<h3>{title}</h3>
{extraHeaderContent}
</div>
<div>{children}</div>
</div>;
}
```
```
Now the parent can decide what to pass as extraHeaderContent – it could be a close button, or
any other element (search box, etc.). If no extra content, they can pass null or omit it. This
removes the need to have a specific boolean prop for each possible extra thing, instead providing a
composition “slot.” React’s children prop is a basic slot for the main content, but you can have
multiple slots via render props or dedicated props for elements.
Example: A Modal component might take header, footer as render props or elements,
instead of many flags like hasCloseButton, hasCancel. This way, a complicated combination of
header/footer can be assembled by the parent and passed in, keeping the Modal implementation
straightforward (just renders the given pieces in the right places).
Don’t do it when...: the boolean is truly controlling an internal behavior not easily provided by
outside. For instance, animate={true} might trigger internal CSS transitions – that’s okay as a
prop because the parent can’t supply the animation code easily. Use this mainly for optional UI
pieces. Also, be mindful that by externalizing content, you potentially make the parent more
complex (it must know to provide those elements). If most parents always want the same header,
having it inside with a boolean might actually be simpler. So gauge if the variability is needed. Too
```
#### •


```
many render prop slots can also make an API confusing, so use with balance (maybe group related
elements into one slot).
```
```
Co-locate Related Components
(Architecture/organization technique but affects simplicity of working with components.)
Intent: Organize components so that those that work together live near each other (e.g., same
folder). This isn’t a code refactor per se, but it simplifies navigating the codebase. A feature-focused
structure (all files for a feature in one folder) often beats separating by type (all components in one
huge folder, all hooks in another, etc.). Co-location reduces the cognitive load when
modifying a feature – you find everything in one place.
How-to: Group files by feature or domain. For example:
```
```
/src/features/ShoppingCart/
CartPage.tsx
CartItem.tsx
useCart.ts (hook)
cartSlice.ts (if redux slice, etc)
Cart.test.tsx
```
```
This way when simplifying or reviewing the Cart feature, you see context and usage easily. Within a
component file, also co-locate things: define helper sub-components inside the same file if they are
small and only used there (TypeScript allows component props to be typed within the file easily). Co-
locate styles (CSS modules or styled components definitions) next to the component. The idea is to
keep related logic together to avoid “hunting” across the project.
Example: Instead of a components/ directory with 50 files and a separate hooks/ dir, consider
feature directories. Many modern codebases follow this. It also aligns with Next.js App Router
conventions (where each route has its own folder with components, loaders, etc. for that route).
Don’t do it when...: your team prefers a different structure or the project is small enough that one
component folder is fine. It’s more of a convention than a code refactor technique, but one that can
reduce accidental complexity in larger projects by reducing how much context a developer needs to
load at once.
```
### Hook Refactoring Techniques

```
Abstract Repeated Logic into a Custom Hook
Intent: As mentioned in principles, whenever you notice the same useEffect or state logic in multiple
places, create a custom hook to handle it once. This not only avoids duplication but centralizes fixes
(e.g., if you need to change how you fetch data or handle subscriptions, you do it in one hook rather
than in every component).
How-to: Identify the inputs and outputs of the logic. For a data fetch example, inputs might be an
endpoint or query, outputs are data, loading, error. Implement the hook as a function that uses
React hooks internally (state, effect, context, etc.) and returns what callers need. Use the hook in
components, passing any parameters. Ensure the hook’s name starts with “use” so that linter rules
and React itself treat it properly.
Example: useDocumentTitle(title: string) – many components might set
document.title. Instead of each having a useEffect, create:
```
#### •

```
54 55
```
#### •


```
functionuseDocumentTitle(title: string) {
useEffect(() => {
const prev= document.title;
document.title= title;
return () => { document.title= prev; };// restore on unmount
}, [title]);
}
```
```
Now components simply call useDocumentTitle("Profile - MyApp") and don’t worry about
cleanup or remembering previous title. Another example, useAuth that wraps context:
```
```
functionuseAuth() {
constctx = useContext(AuthContext);
if(!ctx) thrownew Error("useAuth must be used within AuthProvider");
returnctx;
}
```
```
This avoids repeating the context logic and error handling in every component that needs auth – just
call useAuth().
Don’t do it when...: Only one component uses the logic, and it’s not expected to be reused. In that
case, pulling it out to a hook might add indirection without much gain (except maybe testability).
Also, if the logic is trivial (e.g., a single useState), making a hook for it could be overkill unless it’s a
naming convenience. Avoid making hooks just to “file away” logic that’s only relevant to one
component’s internals – you can instead define a helper function inside that component file.
Remember that hooks cannot be conditional – so ensure any hook you create is used consistently
according to React rules (called unconditionally at top level of components). This might affect design:
sometimes a simple if in a component is easier than a hook that internally decides to do
something conditionally.
```
```
Use useReducer for Complex State Transitions
Intent: When state management within a component becomes complicated (many interdependent
state variables or complex update logic), simplify by using useReducer. This centralizes state
updates in a reducer function, often making the code easier to follow than multiple useState calls
and effects.
How-to: Identify the state pieces that change together or in response to same events. Define a
reducer that takes the current state and an action, returning new state. Replace multiple setState
calls with one dispatch. This reduces the chance of inconsistent state (because you update
everything in one go) and makes the transition logic explicit in the reducer. If the logic is reusable,
you can even make a custom hook around useReducer (e.g., useFormReducer for form field
management).
Example: A form component tracking many fields and error flags. Without reducer, you might have
10 useState calls and complicated useEffect to validate. With useReducer, you define:
```
#### •


```
interfaceFormState{ values: {...}; errors: {...}; }
typeFormAction= { type: 'CHANGE', field: string, value: string } | {
type: 'SUBMIT' } | ...;
functionformReducer(state: FormState, action: FormAction): FormState{
// handle change, validate, handle submit, etc.
}
const[state, dispatch] = useReducer(formReducer, initialFormState);
```
```
Then dispatch actions on events. This can simplify the mental model by grouping logic (especially if
certain events need to update multiple fields).
Don’t do it when...: State is simple. useReducer introduces more boilerplate (action definitions, a
reducer function) which is unnecessary for straightforward cases. For example, toggling a single
boolean or incrementing a counter – useState is perfectly fine. A rule of thumb: if you find
yourself writing setX, setY, setZ in one handler or having state changes in multiple places that
must stay in sync, a reducer might help. Otherwise, keep it simple with useState.
```
```
Encapsulate Side Effects in Hooks
Intent: Any recurring side effect patterns (timers, event listeners, subscriptions) should be wrapped
in a custom hook to ensure correct setup/cleanup and avoid repetition. This not only simplifies
components but prevents bugs like forgetting to remove a listener.
How-to: For a timer, create useInterval(callback, delay) hook that uses useEffect
internally to set setInterval and clear it on unmount or delay change. For event listeners, e.g.,
useWindowEvent(eventName, handler). The hook will attach the event in an effect and detach
on cleanup. The component simply calls the hook and doesn’t worry about lifecycle.
Example:
```
```
functionuseWindowEvent<Kextendskeyof WindowEventMap>(event: K, handler:
(e:WindowEventMap[K]) =>void) {
useEffect(() => {
window.addEventListener(event, handlerasEventListener);
return () => window.removeEventListener(event, handleras
EventListener);
}, [event, handler]);
}
// Usage:
useWindowEvent('resize', () => { console.log(window.innerWidth) });
```
```
Or useInterval:
```
```
functionuseInterval(callback: () => void, delay: number |null) {
useEffect(() => {
if (delay== null) return;
const id = setInterval(callback, delay);
return () => clearInterval(id);
```
#### •


```
}, [callback, delay]);
}
```
```
Now any component can easily set up an interval by calling useInterval(() => {...}, 1000),
and it will be cleared automatically.
Don’t do it when...: the effect is truly specific to one component’s logic and not expected to repeat
elsewhere. But even then, you might do it for clarity. One pitfall: hooks like useWindowEvent as
above might re-bind if the handler function identity changes often (which could happen if not
stabilized with useCallback in the component). Document such requirements or handle it inside
(maybe accept dependencies or use ref to store handler). In general, encapsulating effects is a good
practice if the effect logic is non-trivial.
```
```
Use Context + Hook for Shared State (Provider Pattern)
Intent: Instead of using context directly in components, create a dedicated hook to consume
context and a provider component for it. This abstracts context usage behind an easier API,
preventing misuse and easing refactoring of context shape.
How-to: For a given global-ish state (auth, theme, etc.), create a context and provider that manages
that state (could use useReducer or whatever inside). Export a hook like useAuth() that internally
calls useContext(AuthContext) and returns the value. Use the provider at app root (or
appropriate subtree). Now components wanting auth state just call useAuth(). This pattern hides
the context implementation and ensures consumers get a typed value (the hook can throw if used
outside provider, which helps catch errors).
Example:
```
```
// authContext.tsx
interfaceAuthContextValue { user: User| null; login: () =>void; logout:
() =>void; }
constAuthContext = createContext<AuthContextValue |
undefined>(undefined);
export functionAuthProvider({ children }) {
const[user, setUser] = useState<User|null>(null);
constlogin= () => {... setUser(...); };
constlogout = () => {...setUser(null); };
constvalue= useMemo(() => ({ user, login, logout }), [user]);
return<AuthContext.Providervalue={value}>{children}</
AuthContext.Provider>;
}
export functionuseAuth() {
constcontext= useContext(AuthContext);
if(!context) throw newError("useAuth must be inside AuthProvider");
returncontext;
}
```
```
Then in components:
```
#### •

```
56 57
```

```
const{ user, login, logout } = useAuth();
if(user) { /* show user info and a logout button that calls logout */}
```
```
This pattern (sometimes called the Provider pattern ) is recommended for cleanly handling global
state without prop drilling. By splitting context logic out, components remain simpler.
Don’t do it when...: your state doesn’t actually need sharing beyond maybe two components –
context might be overkill. Also, if performance is a concern, be mindful: context re-renders all
consumers when value changes. If you have a context with frequently changing value (like an input
text context), you might introduce unnecessary re-renders – context+hook is more for convenience
and encapsulation, not solving that performance issue (for performance, you’d consider splitting
contexts or using selectors or something like Jotai/Recoil for fine-grained updates). But in terms of
code simplicity, context+hook is a win for most moderate use cases.
```
```
Use Built-in Hooks Optimally (useMemo, useCallback)
Intent: Simplify performance optimizations by using built-in hooks rather than complex
workarounds. For example, instead of manually tracking prev props to avoid expensive
recalculations, use useMemo. Instead of binding event handlers inline every render, use
useCallback to memoize them when needed. This is less about code volume and more about
clarity: these hooks make the intent explicit (“this value is computed from dependencies and can be
memoized”).
How-to: Identify expensive calculations or frequent re-render triggers. Wrap heavy computations in
useMemo(() => computeExpensive(val), [val]) so it only re-runs when val changes. Use
useCallback(fn, [deps]) for functions that you pass to child components (especially if those
children React.memo or depend on stable function identity). This prevents child re-renders and
also signals to readers that the function doesn’t change unless deps change. However, do not abuse
these: only use when needed (e.g., a list with hundreds of items and an expensive sort, or a
component that re-renders frequently causing expensive function props churn).
Example: A ProductList component that filters and sorts a large list on every render. With
useMemo:
```
```
constsortedProducts= useMemo(()=> {
constfiltered = products.filter(...);
returnfiltered.sort(...);
}, [products, filterCriteria]);
```
```
Now sortedProducts is only recalculated when products or filterCriteria change, not
on every parent re-render.
Don’t do it when...: The logic is cheap or the component isn’t called often. Overusing useMemo/
useCallback can actually add complexity by introducing extra code and potential bugs (e.g., stale
values if dependencies are wrong). The React docs note that premature memoization can make code
harder to understand with minimal benefit. Focus on clear code first; optimize with these hooks
when profiling or obvious bottlenecks suggest it. As a rule: make it work, make it clean, then make it
fast (if needed).
```
```
6 5
```
#### •


### Props and State Techniques

```
Lift State Up (Only) When Necessary
Intent: Ensure state is placed at the lowest common owner that needs it. This avoids both prop
drilling (if too high) and duplicated state (if kept separately in siblings). The technique of lifting state
up is in React docs and helps synchronize components.
How-to: If two sibling components need to share some state or one needs to affect the other, move
that state to their parent and pass it down via props. The parent becomes the source of truth.
Remove local state from the children.
Example: Two text inputs that must stay in sync (perhaps two formats of the same data). Initially
they each have local state and onChange they attempt to update the other via parent callbacks –
complicated. Instead, keep one state in parent:
```
```
const[text, setText] = useState("");
<InputAvalue={text} onChange={setText} />
<InputBvalue={text} onChange={setText} />
```
```
Now both get the same text prop and call back to set it. This eliminates inconsistent state.
Don’t do it when...: the components are actually independent. If InputA and InputB in the above
example didn’t need to sync (they just coincidentally both have text state for different purposes),
lifting would unnecessarily tie them together. Use lifting to remove real duplication or prop drilling
issues, not just to follow a rule. Also, if you find yourself lifting state up to a very high level causing
that high-level component to manage a lot of disparate state, consider if a context or separate state
stores (Redux, etc.) might be more suitable, or if those pieces of state really aren’t needed globally.
```
```
Duplicate State (When It Truly Simplifies and Doesn’t Need Sync)
Intent: This is a contrarian technique – sometimes, duplicating a piece of state in two places is
simpler than trying to force a single source of truth across distant parts of the app. This goes against
the grain of “single source of truth,” but there are cases where two bits of state happen to hold
similar data but don’t actually interact, and coupling them creates needless complexity.
How-to: Recognize when state doesn’t need to be globally shared. For instance, two different form
wizards might each need to store a “currentStep” index. There’s no need to lift that to some parent or
global store – each wizard manages its own. That’s not truly “duplicating” in terms of one piece of
info; it’s independent state. The more interesting case is caching: e.g., you might store a list of items
in a global cache (server state), but also have local component state for a filtered view of those items.
That filtered list is “derived” but storing it locally can simplify rendering logic (you don’t recalc filters
on every render). It’s okay because if the base list changes, you can recalc or discard the derived
state accordingly.
Example: A search input component that manages its own query state and filtering, vs relying on
a parent to hold query and pass filtered results. If the search is self-contained, local state duplication
(the parent might also keep the overall list) can actually isolate complexity. Another example: Wizard
pages each keep track of validation status; you don’t need one giant state object of all pages’
statuses if each page can compute its own.
Don’t do it when...: the two states represent the same single source of truth. If you duplicate state
that must always match (like two different contexts both tracking the current user), you’ll get bugs.
Only have separate state if some divergence is acceptable or they don’t change in lockstep. Also,
```
#### •

#### •


```
document when doing something like caching or derived state: e.g., “we keep a local copy of X for
quick filtering; refresh it when base X changes.” This technique, in summary, is “don’t over-lift state.”
Keep things local unless sharing is needed – which we covered under state colocation principle.
```
```
Eliminate Derived State Anti-Patterns
Intent: Don’t store in state something that can be computed from props or other state, to reduce
the chance of inconsistency. Instead, compute on the fly or memoize if needed.
How-to: For example, if you have a prop items and want to display a count, don’t have a separate
count state that updates whenever items changes. Just use items.length directly. Or if a
prop comes in and you want to tweak it, prefer to derive in render rather than store it in state in
useEffect. If you do need to derive and memoize (like expensive calculation), use useMemo
rather than state.
Example:
```
```
functionItemsList({ items }: { items:Item[] }) {
// anti-pattern:
const[count, setCount] = useState(items.length);
useEffect(() => { setCount(items.length); }, [items]);
```
```
// better: derive directly
constcountDirect = items.length;
// or if heavy:
constheavyCalc= useMemo(()=> expensiveCalc(items), [items]);
}
```
```
The direct approach avoids a whole effect and state variable that could get out of sync or cause
double renders.
Don’t do it when...: computing on every render is actually a performance bottleneck and
memoization is not enough or too complex – in rare cases, you might cache via state. But that
should be last resort. In general, avoid derived state stored in state.
```
```
Use Uncontrolled Components (for Simplicity in Forms)
Intent: For form inputs, sometimes you don’t need React state at all – uncontrolled inputs (using ref
or letting DOM handle it) can drastically cut down boilerplate for simple forms.
How-to: Use the defaultValue or just <input value={undefined}> (which makes it
uncontrolled) and read values on submit via refs or FormData. For example, a basic login form
might not need to update state on each keystroke – only when the user submits do you care. So:
```
```
functionLoginForm({ onLogin}) {
constusernameRef = useRef<HTMLInputElement>(null);
consthandleSubmit= e => {
e.preventDefault();
const username= usernameRef.current!.value;
onLogin(username);
};
```
#### •

#### •


```
return<form onSubmit={handleSubmit}>
<input ref={usernameRef} type="text" name="username"/>
<button type="submit">Login</button>
</form>;
}
```
```
No useState needed for username. This simplifies controlled => uncontrolled trade-off.
Don’t do it when...: you need live validation or instant response to input changes. Controlled
components (with state) are better when each keystroke triggers some logic (enabling a button,
filtering a list in real time, etc.). Also, uncontrolled components are harder to reset (you have to
manually set .value or key-reset the component). So use uncontrolled for straightforward use-
cases where form management overhead isn’t needed. This keeps code minimal, but ensure it
doesn’t compromise user experience or required functionality.
```
```
Use useRef for Mutable Values that Don’t Affect Render
Intent: Sometimes you need to keep track of a value between renders without triggering re-renders
(e.g., an ID counter, previous value reference, or to integrate with non-React code). Using state for
this would be overkill. Using a ref can simplify by avoiding state updates.
How-to: For example, to get the previous prop value:
```
```
constprevValue= useRef(prop);
useEffect(() => { prevValue.current= prop; }, [prop]);
// Now prevValue.current is available for comparison.
```
```
Or to generate unique IDs:
```
```
constidCounter= useRef(0);
functiongetId() {return ++idCounter.current; }
```
```
In a form, if you need an imperative handle to an element (to focus or scroll), use ref, not state. This
avoids stuff like const [scrollY, setScrollY] = useState(0) with effects – better to just
call window.scrollY or use ref to track if needed.
Example: Implementing a debounced search: you can store a timeout ID in a ref so it persists
between renders but doesn’t cause re-renders when updated:
```
```
consttimeoutId= useRef<ReturnType<typeof setTimeout> | null>(null);
functiononChange(text) {
if(timeoutId.current) clearTimeout(timeoutId.current);
timeoutId.current = setTimeout(()=> sendQuery(text), 300);
}
```
```
Here we didn’t need state for timeoutId because we never use it in render output.
Don’t do it when...: the value should cause a re-render or reflect in the UI. If you use a ref where
state is appropriate, you might bypass React’s reactive updates and cause UI not to update. Use this
```
#### •


```
for “instance variables” that are outside the render logic’s concern. Also, be cautious with extensive
use of refs as it can lead to more imperative code style; keep most of your data in state and props,
using refs for escape hatches.
```
### Typing Patterns Techniques

```
Explicit Types at Component Boundaries
Intent: Make component APIs self-explanatory and catch errors early by typing props and return
types, but avoid redundant types internally (relying on inference).
How-to: Always define an interface or type for your component props (or type them inline in the
function signature). For module exports like functions or class methods that will be used elsewhere,
consider explicitly typing the return type to make usage clear. Use React.FC sparingly (it adds an
implicit children and can complicate generics ) – instead define props and write
function MyComp({}: MyProps): JSX.Element. This gives you full control and avoids
React.FC pitfalls with generics and children.
Example:
```
```
interfaceButtonProps { onClick?: () => void; label: string; }
functionButton({ onClick, label}: ButtonProps) {
return<button onClick={onClick}>{label}</button>;
}
```
```
The prop types serve as documentation in editors and ensure callers pass correct props. For more
complex types, prefer composition of types (e.g., type CombinedProps = A & B) to duplication.
Use utility types if needed:
```
```
typePartialUser = Partial<User>;// all fields optional, rather than
making a new type with? marks
```
```
Don’t do it when...: The boundary is internal or obvious. You don’t need to annotate every single
variable – TS is not Java, you can lean on inference. The focus is on public interfaces. Over-annotating
can lead to maintenance burden. Also, if a function’s return type is easily inferred and not part of the
outward API, you can skip it. Some teams enforce explicit return types for exported functions to
avoid accidental any – that’s a reasonable rule (especially with noImplicitAny). But they often
allow omitting for internal helpers. Strike balance: clarity for external interaction, brevity for internal
implementation.
```
```
Use Union Types and Enums for Clarity
Intent: Replace “magic strings” or flags with union types or enum to constrain values and improve
readability.
How-to: If a prop or state can only be a few specific values, define it as such. For instance:
```
```
typeToastType= 'success'|'error' |'warning';
interfaceToastProps{ type: ToastType; message:string; }
```
#### •

```
58 59
```
```
60 59
```
#### •


```
Now ToastProps.type cannot be any string – only those three. This prevents a whole class of
bugs (e.g., passing 'errror' with a typo would be caught by TS). Enums can also be used
(especially if values are not strings, or you want a distinct type), but string unions are often sufficient
and simpler. For deeply related options, discriminated unions (as mentioned earlier) are powerful –
e.g., a Shape type could be a union of different shape interfaces each with their own fields, and TS
can narrow based on a kind property.
Example:
```
```
typeRequestStatus= 'idle' | 'loading'| 'success'|'error';
const[status, setStatus] = useState<RequestStatus>('idle');
```
```
Now you can’t set status = 'done' by mistake. Coupled with an exhaustive switch:
```
```
switch(status) {
case'idle': ...; break;
case'loading': ...; break;
case'success': ...; break;
case'error': ...; break;
default:
const _exhaustiveCheck: never= status;
throw newError(`Unknown status: ${status}`);
}
```
```
ensures you handled all cases – if you add a new union member, TS forces you to update here,
making code safer to change.
Don’t do it when...: The set of values is truly unbounded or not known at compile time (like user
input strings – you wouldn’t enumerate every possible username!). Also, avoid overly granular
unions that change often – if you have to constantly adjust the union, maybe it wasn’t meant to be
so strict. Use unions/enums for well-defined categories that rarely change (or if they do, you want to
update all usage sites). Overusing this can lead to lots of types for things that might have been fine
as free-form (like an error message that can be any string should just be string, not an artificially
limited union). Use your domain knowledge to decide.
```
```
Leverage Conditional Types and Mapped Types for DRY
Intent: Avoid repeating similar type definitions across variants. Use advanced TS features (mapped
types, conditional types) to generate types dynamically when it clearly reduces errors and
maintenance.
How-to: For example, if you have an API response type and want a “loading state” version of it, you
can do:
```
```
typeWithLoading<T> = { loading: boolean; data: T };
typeUserResponse= { name: string; age: number; };
typeUserState= WithLoading<UserResponse |null>;
```
#### •


```
Instead of manually making an interface with loading, error, data each time, you abstract it. Mapped
types like Partial<T>, Required<T>, Pick<T, Keys>, Omit<T, Keys> are your friends to
slice and dice existing types rather than duplicate them.
Example:
```
```
interfaceFormFields{ title: string; description: string; }
typeFormFieldErrors= { [K inkeyof FormFields]?:string };
```
```
This creates a type with the same keys as FormFields but each optional string (could hold error
message per field). Without mapped types, you might manually write:
```
```
typeFormFieldErrors= { title?: string; description?: string; };
```
```
which is fine for two fields but error-prone if fields change or if there are many.
Don’t do it when...: It over-complicates understanding. If a developer unfamiliar with conditional
types looks at it and can’t quickly tell what it means, maybe a little duplication was better. Aim to use
these where they encapsulate a clear pattern. Also, remember TypeScript types don’t add to runtime
bundle – they’re purely for dev. So “DRY in types” is about avoiding mistakes, not runtime efficiency.
Balance between too many magical generic types vs simple explicit types that someone can read.
Comments and good naming help when using advanced types.
```
```
Prefer Type Aliases for Unions, Interfaces for Objects (Style)
Intent: Keep a consistent approach to defining types. Generally, use interface for objects
(especially if you expect to extend them) and type aliases for unions or complex compositions.
This is a widely adopted style (though technically you can use type for objects too).
How-to:
```
```
interfacePerson { name: string; age: number; }
typePersonResponse= Person| null; // union using type alias
typeColor= 'red'| 'green'| 'blue'; // union of literals
```
```
If you need to intersect or union multiple interfaces:
```
```
typeEmployee= Person & { salary: number }; // intersection
```
```
That’s easier with type aliases. interface can’t directly express union, and though it can extend,
type alias is more flexible for that. Meanwhile, interface can merge declarations (allowing
augmentation) and often gives better error messages for object types. Decide on a convention and
stick to it for simplicity. The React TypeScript community often recommends: interface for
component props (since they’re objecty) and type for everything else, or simply type for everything
except you need interface merging. It’s a bit stylistic, but consistency reduces cognitive load.
Don’t do it when...: If your project already has a different convention, this is not critical to change.
It’s more of a guideline. Also, if using third-party types that use interfaces, just adapt accordingly.
```
#### •


```
The key is to avoid confusion like having some props defined with type alias, others with interface for
no reason.
```
```
Use Utility Types and Inferred Types to Avoid Any
Intent: Leverage TS’s utility types (like ReturnType, Parameters, InstanceType, etc.) and typeof
operator to extract types instead of using any or manually duplicating types.
How-to: If you have a function and you want to type something as “what this function returns,” use
ReturnType<typeof fn> instead of guessing or repeating that type definition. This ties the types
together so if the function changes, the dependent type updates. Similarly, if you have a Redux store
or Zustand store, and you want the type of dispatch or state, use typeof store.getState or the
library’s provided types. Many times, you can infer types from usage rather than annotate. For
example:
```
```
constinitialState= { count: 0 , user:nullas User|null};
typeState= typeof initialState;
```
```
Now State is derived directly. Also, if working with generics, you can sometimes use the infer
keyword in conditional types to extract inner types (advanced usage).
Example:
```
```
functionuseMyHook() {/* ... */return { x: 10 , y:'hi'}as const; }
typeMyHookReturn= ReturnType<typeof useMyHook>;
// MyHookReturn will be inferred as { readonly x: 10; readonly y: "hi"; }
because of as const
```
```
Perhaps not useful with as const, but if it was computed:
```
```
functionuseCoords(): { x: number; y:number } { ...}
typeCoords = ReturnType<typeof useCoords>; // {x: number; y: number}
```
```
This saves duplicating the object type.
Don’t do it when...: It makes the code harder to understand. Sometimes explicitly writing out the
type is clearer than using a utility that others might not recognize at first glance. Also, overusing
typeof on extremely large objects can slow TS or produce messy types. But in general, these
utilities are provided to simplify type relationships and avoid mistakes, so they’re a net positive for
code simplicity when used appropriately.
```
### Architecture Techniques

```
Feature-Based Project Structure
Intent: Organize code by feature (or domain area) instead of technical type. This was discussed
earlier, but as a technique: it makes simplifying a feature’s code easier because everything’s together.
It also prevents one file or component from growing too large since you naturally think in terms of
smaller feature components.
```
#### •

#### •


```
How-to: Restructure folders: e.g., /features/Order with OrderPage.tsx,
OrderDetails.tsx, OrderContext.tsx, useOrder.ts, etc. Within a feature, you might have
subfolders for components vs hooks if it grows, but top-level grouping is by feature. Shared utilities
or base components can live in a common/ or shared/ directory. This aligns with scaling advice
to use “feature-based folder structures for scalable code organization”.
Example: In a large app, rather than components/, redux/, utils/, you have:
```
```
src/
features/
products/
ProductList.tsx
ProductDetail.tsx
productSlice.ts (redux logic)
useProducts.ts
...
cart/
CartPage.tsx
CartItem.tsx
cartSlice.ts
useCart.ts
shared/
components/
Button.tsx
Modal.tsx
hooks/
useDebounce.ts
useAnalytics.ts
```
```
This way, to work on “cart” feature, you go to one place. It reduces accidental complexity by limiting
the scope you look at at any time.
Don’t do it when...: The project is small or one-off – then strict organization might not matter, and
you might even keep things in a few files. But even small projects benefit from some grouping. If a
feature is really cross-cutting (like a global search that touches many areas), you might not have a
neat single folder – but you can still organize code related to it in some logical way (maybe under
“search/”). Resist the urge to have too many deeply nested folders though; that can become its own
complexity.
```
```
Introduce a Service/Repository Layer
Intent: Simplify components by moving data-fetching and business logic out of the React layer
entirely, into plain functions or classes (sometimes called services or repositories). Components then
just call these, which returns data or performs actions. This can make components much cleaner
(they don’t need to know how data is fetched, just call service). It also centralizes data logic for reuse
(like if multiple components need to fetch the same thing, they all use the same service function).
How-to: Create a api/ or services/ directory with modules for each domain (e.g.,
userService.ts with functions like getUser(id): Promise<User>). Use those in your hooks
or components. Combine with custom hooks: e.g., useUser(userId) hook internally calls
```
```
54
```
#### •


```
userService.getUser(userId) and manages loading state, etc. The component just uses
useUser and doesn’t know the details. For state updates, a service might encapsulate complex
logic (say, updating multiple stores or sending analytics) so the component simply calls
userService.updateProfile(data) without duplicating that logic.
Example:
```
```
// services/orderService.ts
export asyncfunction placeOrder(order: OrderData):
Promise<OrderConfirmation> {
// handle network request, maybe localStorage, etc.
}
// In component:
consthandleCheckout= async() => {
try{
const confirmation= awaitplaceOrder(cart);
navigate(`/order-confirmed/${confirmation.id}`);
}catch(err) {
showToast("Order failed");
}
};
```
```
The component doesn’t need to know API endpoints or error parsing, the service function hides that.
Don’t do it when...: Over-abstraction alert – don’t create services just for the sake of it. If your data
fetching is trivial and only one component uses it, a service might be extra indirection. But as the
app grows, a service layer can pay off by providing a single source for data logic (and easier mocking
in tests). Also, ensure the service itself doesn’t become too complex; keep them focused by resource/
entity. In Next.js 13 with Server Components, some of this “service” logic might live in server
components or route handlers instead. Adapt the pattern to your stack (the idea remains: separate
non-UI logic from UI).
```
```
Use React Server Components & SSR Thoughtfully
Intent: In Next.js or SSR environments, leverage server components (RSC) and SSR for data fetching
to simplify client-side code. By fetching data on the server, you reduce the amount of client state and
effects needed, thereby simplifying components.
How-to: In Next.js App Router, mark components that don’t need client interactivity as export
const runtime = 'edge' or just default (server by default). Fetch data directly in those
components (e.g., using await on a DB query or fetch call) – this eliminates explicit loading states
on the client for that component, as it will already have data when rendered. Use Suspense
boundaries around lazy components or React.lazy to split code. For parts that require
interactivity (state or browser-only APIs), isolate them as Client Components (using the 'use
client' directive) and only those will hydrate on client. Essentially, push as much as
possible to server components: they don’t carry bundle weight or require lifecycle management on
client.
Example: Instead of a typical fetch in useEffect:
```
#### •

```
61 62
```

```
// Next.js 13 app/page.tsx
import UserProfilefrom'./UserProfile'; // suppose this is a server
component by default
export defaultasyncfunction Page({ params}) {
constdata= awaitgetUser(params.id);// server-side fetch (e.g., from
DB or API)
return<UserProfile user={data} />;
}
```
```
Inside UserProfile (if it remains a server comp): just render with user prop – no loading state
needed. If UserProfile needs a small interactive part (say an “Edit” button that toggles edit
mode), you can split that out:
```
```
'use client'; // at top of that file
export functionEditToggle({ ... }) { ... }
```
```
and use it inside the server comp. The general guidance from Shopify’s RSC best practices: start
components as shared (default), only mark as client if they need to (and even then, consider splitting
out just the piece that needs to be client). If a server component needs to include a client
one (for interactivity), pass data as props or children to avoid making the whole thing client.
Don’t do it when...: If you’re not using a framework that supports RSC or SSR, don’t worry about this.
Also, some components must be client (anything using state, context, browser-only APIs). For Next.js
specifically, follow their conventions; don’t force server if it’s not appropriate (like components using
useState cannot be server). But definitely take advantage of SSR for data-heavy parts to simplify
the client side.
```
```
Establish Module Boundaries (Separation of Concerns)
Intent: Ensure different layers of your app (UI, state management, data fetching, utility) are
separated into modules such that you could change one implementation without cascading changes
in others. This is more of an architectural principle, but practically, it means your React components
should ideally not be littered with direct data-fetch code or complex calculations – they should call
functions from other modules.
How-to: Decide on boundaries: e.g., “UI components do not directly call window.fetch – they call
a function in api/ module.” Or “business logic for calculating prices is in utils/pricing.ts,
not in the component file.” This way, if pricing logic changes, you update one place, and it’s easier to
unit test in isolation. Use TypeScript’s interfaces or abstract classes for contracts if needed (for
example, define an interface for a data store so you can swap implementations in tests or future
changes, i.e., DIP – Dependency Inversion Principle ). In React, context providers often serve
as boundaries (providing an abstraction to the rest of the app).
Example: For state management, you might have a hook like useCart() that internally decides
whether to use Context, or Redux, or Zustand. The components using useCart don’t care how it’s
done. If you later switch from Context to Zustand for better performance, the component code
doesn’t change at all – only useCart implementation might. That’s a separated concern. Another
example: using an adapter for a third-party library – say you have a date library, instead of calling it
directly everywhere, you wrap needed functions in a dateUtils.ts. If you switch libs, you update
```
```
63 62
64 65
```
#### •

```
66 67
```

```
that one file.
Don’t do it when...: it’s a simple usage that doesn’t warrant an abstraction. Over-modularizing can
be as bad as under-modularizing – if you have too many small modules for trivial things, it’s a pain.
Typically, the pain points tell you where a boundary is needed (if changing X forces touching many
files, maybe X wasn’t well isolated). Aim for logical groupings, not necessarily every function in its
own module.
```
### Async/Data Fetching Techniques

```
Use React Query / SWR for Server State
Intent: Offload the complexity of data caching, syncing, and loading states to a library like React
Query (TanStack Query) or SWR. This greatly simplifies your code for anything that involves fetching
and synchronizing server data. Instead of writing repetitive useEffect + useState logic for
loading/error, these libraries provide hooks that handle it and give you simple results.
How-to: Install React Query (if not already). Wrap your app with QueryClientProvider. Then in
components:
```
```
const{ data, error, isLoading } = useQuery(['user', userId], () =>
api.fetchUser(userId));
```
```
The hook takes care of calling the function, caching the result (so if another component calls
useQuery with same key it reuses data), setting isLoading and error states. Your component
code becomes declarative: “I need this data and here’s how to get it.” The library manages when to
fetch (initially and if userId changes) and how to cache. This often means you write no useEffect
at all for data. Likewise for mutations (updates), they have useMutation hooks that handle loading
and error for you.
Example: Before:
```
```
const[data, setData] = useState(null);
const[error, setError] = useState(null);
const[loading, setLoading] = useState(true);
useEffect(() => {
fetch('/api/data').then(res=> res.json())
.then(setData)
.catch(setError)
.finally(()=> setLoading(false));
}, []);
```
```
After (with React Query):
```
```
const{ data, error, isLoading } = useQuery(['data'], fetchDataFn);
```
```
No effect needed; also gets refetch on window focus by default, caching, etc. Kent C. Dodds
recommends treating server state as a cache and using such libraries: “caching is hard... wise to
stand on the shoulders of giants... that’s why I use and recommend react-query”. This aligns with
```
#### •

```
45
```

```
simplifying code by not reinventing wheels.
Don’t do it when...: your data needs are extremely simple or one-off. Adding a library has overhead
(bundle size, learning curve). If your app just fetches a couple things and doesn’t need caching or
realtime updates, the built-in fetch+state might suffice. However, in production apps, data
complexity tends to grow; adopting React Query early can prevent a lot of custom state bugaboos.
Another caution: these libraries introduce their own paradigms; devs must know how to use them
properly. But overall, for anything beyond trivial, they simplify code and improve robustness.
```
```
Handle Loading and Error States with Suspense (where possible)
Intent: Use React’s Suspense for data fetching/loading UI to avoid manual state handling for
spinners and fallback UI. Suspense lets you declaratively show a fallback while a component
“suspends” (e.g. waiting for data). This can greatly simplify data-loading components by eliminating
explicit if (loading) return <Spinner/> checks scattered around.
How-to: This often requires integrating with a data library that supports Suspense (React Query can
with a config, or Relay, or Next.js RSC naturally suspends during fetch). Alternatively, using
React.lazy for code-splitting can also be handled by Suspense for component loading. Wrap
parts of your tree in <Suspense fallback={<LoadingSpinner/>}>. Then inside those, if a
component “throws” a promise (a Suspense mechanism) or is a lazy component not yet loaded,
React will catch it and show the fallback until ready. Plan Suspense boundaries around chunks
that can load independently – not too fine-grained (don’t put Suspense around every tiny
component) but around sections of UI that can load separately.
Example:
```
```
<Suspensefallback={<Spinner/>}>
<CommentsListpostId={id} /> {/* this component suspends until comments
loaded */}
</Suspense>
```
```
In CommentsList, if using React Query:
```
```
useQuery(['comments', postId], fetchComments, { suspense: true});
```
```
When useQuery is in suspense mode, if data isn’t ready, it will throw a promise that Suspense
catches. So CommentsList can just assume data is there:
```
```
constcomments = useQuery([...],...,{ suspense: true}).data;
return <ul>{comments.map(/* ... */)}</ul>;
```
```
No explicit loading check in CommentsList – Suspense handled it. Error boundaries can similarly
catch errors so you don’t have if(error) in every component. This leads to cleaner, linear code.
Don’t do it when...: you aren’t comfortable with Suspense yet or using a library that doesn’t support
it for data. Suspense for data is still not fully mainstream (aside from specific libraries and Next.js
RSC where it’s default). If not using it, you’ll write manual loading states – that’s fine, just a bit more
code. Also, Suspense requires thinking about splitting your UI (you might need multiple boundaries
```
#### •

```
68
```
```
68
```

```
if you want different spinners for different sections). It’s powerful but adds a different mental model.
Use it once you see benefits for your case (e.g., simultaneous loading of independent parts, fancy
skeleton UIs, etc.). In summary, Suspense can reduce boilerplate, but ensure your team and tools are
ready for it.
```
```
Prefetch and Cache Data to Reduce Prop Drilling
Intent: In SSR or using context, consider prefetching data higher up (server or parent component)
so that you don’t need to pass data through many layers or fetch it multiple times. This isn’t
simplifying code in terms of lines, but in terms of data flow (which affects complexity).
How-to: In Next.js, use getServerSideProps or getStaticProps (in Pages router) or load
data in layout (App router) so that pages get data via props. Or use a context provider that on mount
fetches required data and provides it. The components down the tree then just consume from props
or context, no effect needed in each. This centralizes data fetching logic. It can also reduce total code
if multiple components need the same data – fetch once in parent, distribute via props/context.
Example: A classic case: you have a UserPage that shows user info and a list of posts. Instead of
having <UserProfile/> component call fetchUser and <UserPosts/> call fetchPosts
(possibly duplicating user fetch if posts also need user info), fetch both in the page container (maybe
in an async loader function), then render:
```
```
<UserProfileuser={user} />
<UserPostsposts={posts} />
```
```
Each child is now a simple presentational component. This is especially beneficial in SSR because you
avoid the loading flicker on client – data is ready.
Don’t do it when...: data is truly specific to a child and prefetching would waste bandwidth (e.g.,
fetching a lot of data that the user might not end up seeing). Also if it complicates the parent
significantly, weigh the tradeoff. Prefetching and caching make most sense for data that is needed
anyway and/or expensive to fetch (so you want to do it as few times as possible). Modern libraries
(React Query again) will let each component fetch but actually share the cache, so even if two
components ask, it only fetches once – an alternative approach without manual coordination. So use
whichever approach leads to simpler code in your context.
```
```
Gracefully Handle and Log Errors
Intent: Simplify the impact of errors by catching them in one place (error boundary) and logging or
displaying a fallback, rather than peppering try/catch in every async call in components. This ties into
the Error Boundary concept from principles but specifically for data fetching: centralize error
handling logic.
How-to: Use a library like react-error-boundary which provides a component and hooks for
error states. Wrap sections of app that might throw (e.g., a profile section that may throw if user not
found). Provide a fallback UI that is user-friendly (like an “Oops, something went wrong” with a retry
button perhaps). In the fallback component or via onError callback of error boundary, hook in an
error logging service (Sentry, etc.) to automatically report issues. By doing this, your components
don’t each need their own error UI logic; they can just throw (or let an exception happen) and the
boundary catches it. For example, a data hook could throw an error object if the fetch fails (React
Query can be configured to throw in suspense mode), and an ErrorBoundary will catch it and show
an <ErrorFallback error={error} />. This removes error-handling code from dozens of
```
#### •

#### •

```
41
```

```
components into one place.
Example:
```
```
<ErrorBoundaryFallbackComponent={ErrorFallback}
onError={logErrorToService}>
<Suspensefallback={<Spinner/>}>
<UserDetails/>
</Suspense>
</ErrorBoundary>
```
```
In UserDetails, if fetch fails, it throws. ErrorFallback UI could have a “Retry” button that calls
resetBoundary (from react-error-boundary) to retry. This pattern centralizes error display logic.
Don’t do it when...: you need fine-grained error handling (maybe some errors you want to handle
locally). You can mix approaches: handle certain expected errors within a component (like form
validation errors you catch and display next to a field) versus unexpected errors you let bubble to
ErrorBoundary. Also, if not using Suspense, you’ll still use local error state. But you can still avoid
duplicating too much: perhaps create a common <ErrorMessage> component to display errors
consistently, and use it in all places, so styling and wording is uniform. The goal is to not have every
component reinvent its error handling wheel.
```
### Testing Simplification Techniques

```
Use High-Level Tests (Avoid Testing Implementation Details)
Intent: Write tests that verify the behavior of components and integrations, rather than testing
internal state or method calls. This way, you can refactor components (simplify, split, etc.) without
rewriting tests as long as the outward behavior remains the same.
How-to: Use React Testing Library (RTL) which encourages testing from the user’s perspective –
query the DOM as a user would (by text, role, etc.), simulate events, and assert on outcomes in the
DOM. Avoid digging into component instance variables or mocking internal hooks – treat it as a
black box. For state management, you might write some integration tests that include the provider
and ensure that e.g. adding an item updates the UI. Write fewer but more meaningful tests: one
good test that covers a user flow can be more valuable than 10 tests checking each little setState call
(which are brittle).
Example: Instead of testing “if I call toggleMenu() then state isOpen becomes true” (which ties to
implementation), test “if user clicks the menu button, the menu is visible” – which queries the DOM
for the menu element. This test will still pass if you refactor from useState to useReducer or even to
a different menu component under the hood, as long as clicking still shows the menu. Kent C. Dodds
emphasizes avoiding testing implementation details as it makes tests fragile.
Don’t do it when...: There are certain logic-heavy functions (like complex data transforms) where
unit tests on the function itself can be valuable. That’s fine – extract that logic to a pure function and
test it directly. But the component rendering and state transitions, prefer testing via the public
interface (user interactions, props). Also, if your app has critical pieces of logic in custom hooks or
reducers, do test those in isolation (they're still outward behavior of that module). The main point is
to not test things tied to how the component works internally, which would make refactoring scary
because tests would fail for non-user-facing changes.
```
#### •

```
69 70
```
```
69
```

```
Use Test Utility Functions and Custom Renderers
Intent: Reduce boilerplate in tests by creating your own render wrapper that includes common
providers, and utility functions for repetitive actions. This keeps tests focused on what’s under test,
not setup.
How-to: If many tests need a Redux provider, Router, or context, create a utility:
```
```
constrenderWithProviders= (ui, { reduxState, route} = {})=> {
returnrender(
<Providerstore={makeStore(reduxState)}>
<MemoryRouter initialEntries={[route ||'/']}>
{ui}
</MemoryRouter>
</Provider>
);
};
```
```
Then tests can do:
```
```
renderWithProviders(<MyComponent />, { reduxState: {user: {...}},route: '/
home'});
```
```
instead of repeating that wrapper logic every time. Similarly, define clickButton(text) or
enterText(label, value) using RTL’s fireEvent or userEvent, to make tests read like English.
e.g.:
```
```
functionenterText(label, value) {
fireEvent.change(screen.getByLabelText(label), { target: { value} });
}
```
```
Then enterText('Username', 'Alice') in a test is clear.
Example: If testing form submission in multiple tests, factor out the fill-and-submit steps:
```
```
functionfillLoginForm(username, password) {
enterText('Username', username);
enterText('Password', password);
fireEvent.click(screen.getByRole('button', { name: /login/i }));
}
```
```
Now each test can just call fillLoginForm('alice', 'secret') and then assert results,
avoiding duplicate code.
Don’t do it when...: one test has very unique setup – custom utilities should cover broad use cases,
but if something is one-off, it’s fine to inline it. Also, strike a balance: abstracting too much can make
tests harder to understand because the logic is hidden in utilities. The goal is to remove obvious
```
#### •


```
repetition and noise (like mounting providers), not to hide the essence of the test. When done right,
utilities make tests more declarative and easier to write and maintain.
```
```
Favor Fewer, High-Value Tests Over Many Low-Level Tests
Intent: In a complex UI codebase, 100% coverage is not the goal – having confidence is. Often, a few
integration tests covering major user flows catch more bugs than dozens of trivial unit tests. And
they tend to be more resilient to refactoring because the overall behavior stays constant even if
internals change.
How-to: Identify key flows (e.g., “user can add item to cart and see it in cart list”) and write tests for
those end-to-end (possibly using something like Cypress or Playwright for full browser testing, or at
least integration within React Testing Library with all providers). Use realistic scenarios in tests, not
mocks of everything – e.g., use MSW (Mock Service Worker) to simulate API calls in tests rather than
mocking fetch in every component test. This means if you refactor from fetch to Axios, tests still pass
because MSW intercepts network calls at a lower level. It also tests more of the stack.
Example: Instead of unit testing CartContext in isolation and CartButton separately, write a
test that renders the whole app (or that feature) with context, performs a user action (click "Add to
cart"), and then expects the cart count to update in the UI. This is a higher-level test that covers
context + component integration. If you later change from context to Redux or some other state, you
just adjust the provider in the test setup, the test steps remain the same.
Don’t do it when...: something is truly complex and unit tests can pinpoint issues (algorithmic code,
complex math, etc., should be unit tested). Also, too high-level tests can be slower – so you still may
keep some small tests for pure functions, etc. But generally, avoid exhaustive testing of
implementation minutiae like “this hook sets state X when Y” – likely a broader test would catch if X
wasn’t set (because UI would be wrong). This perspective helps keep test maintenance low as you
simplify code.
```
```
Use TypeScript in Tests
Intent: Write tests in TypeScript (or at least have them type-checked) so that when you change types
in your code, tests that are no longer valid will fail to compile. This is a safety net that your tests
aren’t calling components with wrong props or using outdated APIs. It simplifies catch of refactor
issues.
How-to: Configure your testing framework to support TS (Jest works with ts-jest or Babel, etc.). Write
tests as .tsx/.ts. When importing components, you get the benefits of typed props in the tests.
If you remove or change a prop, the test will error if it was using it. This prevents false sense of
security where tests pass but are actually not testing correct usage because they called with wrong
things.
Example: If LoginForm props type changes from onLogin: () => void to
onLogin: (user: User) => void, any test that was rendering
<LoginForm onLogin={() => {}}> will error, prompting you to update the test to match new
usage. That’s good – it means the test will simulate things correctly.
Don’t do it when...: Actually, there’s little downside to using TS in tests, aside maybe initial setup.
Some might argue tests should be vanilla so any developer can write them, but if your team is using
TS everywhere, tests should too. It contributes to overall consistency and safety.
```
By employing these techniques, you not only simplify individual pieces of code but also the development
workflow: components become easier to reason about, hooks and state have clear patterns, and tests are
less brittle.

#### •

#### •


## Decision Heuristics

Engineering is all about trade-offs. Here are some heuristic guidelines to help decide between different
approaches when simplifying a React+TS codebase:

```
Hook vs Component: If you want to reuse behavior (stateful logic, side-effects) across multiple
places with different UI, use a custom hook. If you want to reuse UI structure (markup/styling) in
multiple places, use a component. For example, a hook useSortedList could provide sorting
logic to many list components that each render differently. Conversely, a List component might
be a generic UI piece you reuse for similar structure. Also consider scope: a hook can also be a way
to break up a single large component’s logic without splitting its UI (improving readability), whereas
a sub-component breaks the UI. If the “chunk” of logic naturally maps to a piece of UI (like a sub-
section of the JSX), a component extraction makes sense. If it’s purely background logic (e.g.,
listening to window events, form handling) without its own distinct UI, a hook is more appropriate.
Red flag: don’t create a custom hook for every single component’s logic just to “get it out of the
component” – that can be over-abstraction. Use hooks when it genuinely makes the code
cleaner or more reusable.
```
```
Explicit Prop Types vs Inference: Explicitly type a component’s props when the component is part
of your public interface or used across many places – it improves clarity and ensures callers get
proper intellisense. For small inline components or deeply internal components, you can often rely
on TS inference (especially if you pass props through). A good rule: exported components should
have an explicit Props type/interface , documented via TypeScript. Internal (non-exported)
components can often infer from usage. Also, if props involve generics or more complex types,
explicitly typing them (or the function parameters) is better for readability. Type inference shines for
local variables, inline callbacks, etc. – don’t annotate those unless needed (it reduces noise).
Example: for a component <SearchBar onSearch={(query) => ...} />, you’d define
interface SearchBarProps { onSearch: (query: string) => void; }. But inside
SearchBar, you might have const [text, setText] = useState('') without an explicit
type because TS knows it’s a string.
```
```
Lift State vs Duplicate State: Default to a single source of truth for any given piece of data that
multiple components use – usually by lifting state to the closest common parent or using context.
But if two states track similar things that are actually independent (e.g., two separate search inputs
on different screens), that’s not really one piece of state – keep them separate. Essentially, lift state
up when: (a) two sibling components need to reflect the same data or one needs to control the other,
or (b) a parent needs to orchestrate an interaction between children. Duplicate state (or rather keep
separate states) when the coupling is only conceptual but not needed in code. As an example, if you
have a global list of items and also component-specific filtered list, it’s okay to have component keep
its filtered subset rather than pushing filter state globally. Another heuristic: if you find yourself
passing down a value through many layers, consider context or lifting to a higher context. If you find
yourself constantly deriving a value in multiple places (like computing the same thing in two
components), maybe that should be lifted and computed once. On the other hand, if state in one
component doesn’t affect anything else, keep it local – don’t lift it without reason. Also recall that
sometimes duplicating for convenience is acceptable if you document the relationship (e.g.,
“ComponentA keeps a copy of global state X for fast access – reset it when X changes”).
```
#### •

```
21 22
```
#### •

```
27
```
#### •


```
Signs of Over-Abstraction / Over-DRY: Beware of “patterns” that make code harder to follow:
```
```
If you have components with names like
withSomethingHOC(HigherOrderComponent(BaseComponent)) nested multiple layers, or a
component wrapped by 5 different context providers that all could be optional – that’s a sign of too
many abstractions for maybe trivial things.
If a single function is split into 10 small functions each called in one place because someone tried to
make everything “reusable” or under 5 lines, that could be over-abstraction (functions/components
need a balance between brevity and encapsulating a coherent chunk of work).
If understanding a feature requires jumping through multiple indirections (e.g., event goes into
context, triggers a redux action, saga, store update, then a prop flows down – when it could have
just called a function), consider simplifying that pipeline.
Over-DRY: If you see a lot of config-driven or meta-programming style code for something that
would’ve been easier to just write directly, that might be a smell. As Dennis Persson put it, layers
upon layers of abstraction for code that was only used once is a huge smell. A concrete example:
using a data-driven approach for a form with 3 fields, making it hard to just add a special case – a
simpler hardcoded form might be easier.
Another red flag is context abuse : using context for things that only a couple components need, or
using one giant context for everything. This can signal trying to DRY things up in a way that backfires
(all components re-render on any change, and it's not clear which part of context they depend on).
Magic numbers or strings spread around : If you see the same string literals or numbers in many
places, that might be fine (if it's just “Submit” text), but if it's something like 'USER_ROLE_ADMIN'
repeated, maybe an enum or constant would be appropriate (not exactly abstraction but a
maintainability improvement).
Extreme generic components : e.g., a component that takes 10 render props to handle every case,
used in only one place currently – that’s over-engineered. It’s better to have a simpler component
specialized for current needs, and generalize when you actually have multiple use cases.
```
In general, _listen to your code_ : if adding a small feature requires touching too many files or understanding a
complex framework you built, that’s a sign the abstraction might be too much. Simpler is usually better, and
as the overengineering article noted, _“sometimes duplication is cheaper than the wrong abstraction”_. Use
that as a guiding principle – err on the side of clarity, and abstract later when you have enough information
to do it right.

## Simplification Playbook

When faced with a messy React+TS component or codebase, follow this step-by-step playbook to
systematically simplify and improve it:

**1. Establish Baseline Behavior**
- **Run existing tests** (or create basic tests if none): Ensure you have a safety net. Write a few critical tests
covering what the component _should_ do (render output given props, crucial interactions). These will catch
regressions. If the component is visual and you have Storybook or screenshots, note the expected
output for given props. _Goal:_ know the correct behavior so you don’t unintentionally change it during
refactor.
- **Document current props and types:** Sometimes messy components have hidden assumptions. Write
down what props it takes and what it does with them. If any props are overly complex or any state is

#### •

#### •

```
15
```
-

#### •

#### •

```
53
```
#### •

#### •

#### •

```
34
```
```
71
```

derived, mark that as something to possibly simplify.

- **Measure “complexity metrics”:** Count things like number of props, number of state variables, levels of
nesting in JSX, and how many times it re-renders (you can use React DevTools profiler) or how deep the
component tree is. These metrics (prop count, context usage, depth) are the “prop churn, context bloat,
render depth, re-render” indicators. For example, prop churn: if parent passes new object literals each time
causing re-renders, note that. Context bloat: is the component reading from too many contexts? Render
depth: how many nested child components does it contain? These aren’t precise numbers but give a feel.
_Goal:_ have a baseline so you know if you improved things (e.g., reduced prop count from 10 to 5, or
removed one layer of nesting by eliminating an unnecessary wrapper).
**2. Remove Dead or Redundant Code**
- Delete any commented-out code, console.log statements, or variables that have no effect.
These add noise and risk confusion. If something is truly unused, removing it cannot change behavior
(verified by tests). Use ESLint or TS compiler to help find unused vars and imports. As Alex Kondov says, _“no
reason to have dead code... if you ever need it again, it’s in version control.”_
- Simplify expressions: e.g., replace !!flag? true : false with !!flag or remove always-true
conditions. Inline trivial variables if they just alias props. Basically, streamline the code to its essential logic.
This often immediately improves readability and may reveal the core structure.
**3. Identify Logical Segments**
- Look at the JSX: break it into sections (maybe by visual areas, or conditional blocks). For each section,
figure out what state/props it uses. This often hints at component boundaries. E.g., “This half of the
component is a complex table, and state X, Y are only used there” suggests that table could be a child
component receiving X, Y as props.
- Look at state usage: if you have many useState/useReducer, group them conceptually. Are some
states related (like a bunch of form field states)? Perhaps they belong in a custom hook or object. Are some
purely derived from others or props? Mark those to possibly remove (derived state anti-pattern).
- Consider side-effects (useEffect): what are they doing? If an effect is doing data fetching, that might be
moved to a custom hook or higher-level (context or query lib). If an effect is doing DOM manipulation
(scroll, etc.), maybe it could be a separate concern or custom hook.
**4. Apply Refactor Patterns Iteratively**
Start applying the techniques from the catalog in a sensible order: - **Split components:** If identified, extract
child components one at a time. After each extraction, run tests/validate to ensure nothing broke. Example:
you isolate a <NestedItem> from a huge list rendering function. Pass necessary props. Verify it renders
same. This reduces the parent complexity step by step.
- **Extract hooks:** If the component has complex logic (forms, fetching), implement a hook for it. For
instance, move all form state and validation into useMyForm which returns { fields, errors,
handleFieldChange, handleSubmit }. Replace component logic with hook usage. Confirm behavior
unchanged (tests or manual).
- **Simplify state:** If you found derived state or unnecessary lifting, refactor that. Perhaps remove a piece of
state in favor of calculating on the fly (with memo if needed). Or combine multiple related state values into
one state (using an object or reducer) if they change together, to avoid inconsistent states. After this, see if
some state becomes unused or simpler.
- **Prop handling:** If the component takes a prop only to pass it down to children (prop drilling scenario),
consider providing that via context or passing directly to the child if possible. Or if a prop is always the same
(like a constant config), maybe the child could import that config instead of receiving via prop, to reduce

```
72 73
```
```
74
```
```
75
```

prop surface. Little tweaks like that can reduce “prop clutter.”

- **Styling and markup cleanup:** Not the focus, but sometimes simplifying includes removing extra <div>
wrappers, using React fragments, or moving large chunks of inline styling to CSS. This can reduce the
perceived complexity in JSX.

Do these in small commits if possible, so if something goes wrong, it's easy to backtrack. The mantra:
_refactor in small steps, run tests often_.

**5. Strengthen Component Boundaries**
- After splitting/extracting, reevaluate: does each new component have a clean API? Add Prop types for
them (if TS didn’t infer nicely). Make sure they don’t implicitly rely on something from context that isn’t
obvious. If they do use context, consider accepting that value as a prop (so parent reads context and passes
it), making the usage more explicit and testable. Component boundaries should be such that you could take
that component into Storybook with mock props and it works. If not, adjust.
- Enforce invariants with TypeScript: e.g., if your component now can be in “loading” or “loaded” mode,
maybe use a union type for props to reflect that. This way, if someone tries to use it wrongly, TS will error.
Basically, use the refactor as a chance to improve types around the component contract.
**6. Optimize for Change**
- Think about likely future changes. The simplified code should make those easier. For example, if previously
adding a field to a form required touching code in multiple places, now maybe with a form hook and a
mapped fields structure it’s one place. Or if adding a variant of a component was hard, now maybe it’s just
adding a new component or prop. Weigh your solution by how it handles extension. This doesn’t mean add
speculative features (no overengineering!), but ensure the common extension points are simple. For
instance, after refactor, check if there's any duplicated logic left that might diverge – maybe factor that into
a utility.
**7. Measure Improvement**
- Compare with baseline: Prop count reduced? For example, maybe you eliminated 3 props that were thread
through multiple layers by using context. Context bloat reduced? Perhaps the component now consumes 1
context instead of 3 because some logic moved. Render depth improved? If you removed wrapper
components, the component tree is shallower (you can inspect the Elements tree or React DevTools
component tree to verify fewer layers).
- Count lines of code or conceptual units: Did the component file shrink significantly? Many times, a messy
500-line component can be turned into a 200-line component plus some helpers – a big win. Lines aren’t
everything, but fewer lines (or better-structured lines with whitespace and comments) generally mean
easier readability.
- Check re-render behavior: Use React DevTools “Highlight updates” or why-did-you-render (if configured) to
ensure that unnecessary renders are gone. For example, if before the component was passing down inline
functions causing child re-renders, maybe now you used useCallback or moved the function down, so
child doesn’t re-render needlessly. Track these improvements qualitatively.
- Test performance if relevant: If the component was slow (maybe because of heavy computations), see if
using memo or splitting it helped.
**8. Quick Wins vs Deep Clean**
- **Quick wins** are the low-hanging fruit: removing dead code, renaming variables for clarity, breaking one
huge function into a couple smaller ones, adding comments or TODOs for things noticed. These you do

```
72
```

first, as they carry little risk but improve understanding. Another quick win: adopt a consistent formatting/
linting (Prettier, ESLint) – not exactly code logic change, but a one-time format can standardize the style and
reveal structure.

- **Deep clean** steps are larger refactors: e.g., switching from Redux to context or to React Query for data, or
re-architecting state management across the app. These need planning and maybe incremental rollout. For
a deep clean, break it into smaller tasks and maybe put behind feature flags or do parallel implementation
and then switch. For instance, if moving to React Query, you might keep old fetch logic working and
introduce the query hook, test it, then remove old code when confident. A _deep clean playbook_ might span
days/weeks, whereas quick wins you do in hours.
**9. Communicate Changes**
- If working in a team, share what you’re doing: e.g., “Refactored ComponentX: extracted SubComponentY,
introduced useZ hook. Behavior unchanged but code is simpler.” This helps reviewers focus on verifying no
behavior change and understanding new structure. Provide before/after comparisons if possible (like "prop
count from 12 to 5, lines of code from 300 to 180"). This not only validates improvement but also educates
the team on these simplification practices.

Following this playbook ensures you methodically improve the code: you secure correctness first, then chip
away complexity, measure the gains, and avoid scope creep (since you have discrete steps and checks).
Over time, applying this to many parts of the codebase yields a more maintainable, robust system.

## Code Review Ruleset for Simplicity

To maintain simplicity in a React + TypeScript codebase, adopt a clear code review checklist. Rules are
categorized as **MUST** , **SHOULD** , and **AVOID** , reflecting priority. Engineers and reviewers should enforce
these to keep code lean and clean.

**MUST:** (Strict requirements – code should not be approved if these are violated) - **MUST keep components
focused:** A component must have a single clear purpose. If a component exceeds, say, ~300 lines or
handles unrelated concerns (data fetch + UI + complex state all in one), it must be refactored into smaller
components or hooks. Each component or hook should “do one thing well” (Single Responsibility Principle)

. - **MUST type all component props and public functions explicitly:** No usage of any in prop
definitions. All props should be typed with interface/type, including children if used (via
React.ReactNode or PropsWithChildren) – no any or implicit any for children. This ensures
consumers get compile-time feedback. - **MUST handle errors and nulls:** Components must gracefully
handle null/undefined data if their props or context indicate it can happen (per types). For example, if a
prop is user?: User, the component must have a branch for when user is undefined (like not rendering
or showing a fallback). No blind accesses that could cause runtime errors. If something truly should never
be null, mark it required in types. Use non-null assertions only if absolutely certain (rarely). - **MUST clean
up side effects:** Any hook effect that subscribes (events, intervals, async calls) must return a cleanup to
prevent leaks. E.g., remove event listeners, clear timers, cancel fetches (if possible) on unmount. This is
critical to avoid memory leaks and weird behavior on fast navigations. - **MUST avoid direct DOM
manipulation unless necessary:** Use React state/props to control UI. If direct DOM manipulation (via
querySelector or refs) is needed, ensure it’s encapsulated and doesn’t conflict with React’s rendering.
E.g., using refs to manage focus or animations is fine, but updating DOM to add elements is not (should go
through React). - **MUST ensure lists have stable keys:** Any .map rendering a list must have a key prop
on the items. Keys should be unique and stable (no using index as key unless list is static). This prevents

```
76
```
```
1
26
```
```
77
```

unnecessary re-renders and UI bugs. - **MUST remove debugging artifacts:** No console.log or
commented-out code in PRs. No leftover debugger statements. Lint should catch these; they
should be cleaned before review. - **MUST follow established patterns for consistency:** If the project uses a
specific state management (Context or Redux) or a styling approach, new code must use it rather than
introduce a conflicting approach. E.g., don’t add MobX to a Redux project for one piece of state – stick to
agreed patterns unless evolving the architecture intentionally.

**SHOULD:** (Recommended best practices – not absolute, but deviations should be justified) - **SHOULD prefer
functional components + hooks over class components:** Unless there’s a compelling reason (like an error
boundary or legacy integration) to use a class, use functions and hooks. Hooks generally result in less
boilerplate and easier composition. If a class component is introduced (aside from ErrorBoundary), ask why
and consider a hook alternative. - **SHOULD minimize prop drilling:** If you see more than 2 layers of
components passing the same prop, consider suggesting context or a different structure. Prop
drilling is not evil, but if a prop is passed through components that don’t use it just to reach a deeply nested
component, think about refactoring (maybe the nested component could be moved up or context used). -
**SHOULD keep prop interfaces small:** Prefer a few focused props over a long list of booleans and optional
values. If a component has many optional props, consider grouping them or splitting the component. For
instance, instead of <Button primary secondary rounded outlined ...> which is contradictory/
confusing, maybe have a variant prop or separate components for common variants. - **SHOULD use
descriptive prop and state names:** e.g., isLoading instead of flag or dataList instead of arr.
Boolean props state should read like true/false (prefix with is/has/should). This greatly improves
readability. - **SHOULD default undefined props where sensible:** Provide default values for optional props
(via function default parameters or defaultProps). This avoids repetitive checks inside component and
makes usage easier. E.g., function Panel({color = 'blue'}:{color?:string}). - **SHOULD use
immutability and pure functions for state updates:** In context/reducers, don’t mutate state directly. In
components, avoid doing things like someArray.push in state – use spread or functional updates. This
prevents bugs and aligns with React expectations. - **SHOULD separate presentational and logical
concerns:** Not necessarily via separate components always, but logically organize code. For example, fetch
data in top of component or custom hook, then render pure JSX below. Or use container/presentational
pattern if component is reused in different contexts. This makes it easier to test and maintain. - **SHOULD
write unit tests for complex logic:** If a component includes complex transformations (e.g., a utility to
calculate a schedule, or a tricky algorithm), that logic should be factored out and unit-tested. The
component test can then focus on rendering given the outcome of that logic (which you might mock or use
real logic). - **SHOULD favor composition over inheritance/large conditional props:** We covered
composition vs if/else. If reviewing code where a component has both type="A" and type="B" modes
internally, consider if two components would be cleaner. Or if an “extends BaseComponent” approach is
taken, could composition achieve same? Composition is the norm in React. In general, if else ladder
beyond 2-3 cases might mean separate components. - **SHOULD use ESLint and Prettier to auto-enforce
style:** Consistent code style reduces mental overhead. For example, ensuring dependency arrays in
useEffect are correct (eslint-plugin-react-hooks) – that’s a simplicity issue too (avoids stale state bugs).
TypeScript ESLint rules to catch any or unused vars should be on. Code that passes lint with our rules is
typically simpler/cleaner by default. - **SHOULD document non-obvious decisions:** A short comment
explaining why a certain pattern is used (e.g., “using ref instead of state here to avoid re-renders” or “using
context to avoid prop drilling of theme”) helps future maintainers. It’s easier to maintain simple code if one
understands the intent. Complex hacks _must_ have comments.

```
72 74
```
```
9 11
```
```
26
```
```
78 79
```

**AVOID:** (Things that should generally not appear; if they do, likely require changes) - **AVOID massive
contexts or props as dumping grounds:** Don’t stuff a context with 10 unrelated values just to avoid prop
drilling everything. Break contexts by concern (auth context, theme context, etc.). Similarly, avoid single
prop objects with too many fields when you can pass just what’s needed (e.g., don’t pass an entire user
object to a component that only needs user.name – pass name or even better, have that component call
a hook to get user if it’s global). Overloading contexts/props makes it unclear what a component actually
depends on. - **AVOID using any or @ts-ignore:** These should be extremely rare in a well-typed
codebase, only as last resort for library issues. If a prop is hard to type, better to improve type definition or
isolate the any in one place. An @ts-ignore silences the compiler but could hide real problems – so treat
it as a temporary workaround to be resolved. - **AVOID inline functions/objects that cause needless re-
renders:** If a component passes an inline arrow function to a child that is pure (React.memo), that child
will re-render every time because the function prop is new on each parent render. Use useCallback or
define the function outside render so that child only re-renders when needed. Same for objects/arrays – if
you pass {some: value} as prop, that’s new each time; use useMemo or define constants outside if
appropriate. Not every case needs memoization, but be mindful if perf issues arise. As a rule: avoid creating
new references in render if the child is performance-sensitive. - **AVOID complex one-liners and deeply
nested ternaries:** As mentioned, code should be readable. If you see return condition1? foo :
condition2? bar : baz; nested, ask for it to be rewritten for clarity (either if/else or separate
components/logic). We want to avoid the scenario where only the original author can understand the
code. Similarly, heavily chained Lodash calls can sometimes be broken into clearer steps. - **AVOID
duplicating logic across multiple places:** This is the flip side of over-DRY: if the same 20 lines of logic exist
in two components, that’s a maintainability issue. They should probably share a hook or utility. E.g., form
validation code copy-pasted in two forms – better to have a shared validator function. Or a chunk of UI
repeated – maybe a common component. Use judgment: small duplication (a couple lines) is fine if merging
would complicate things, but significant duplication should be addressed to avoid divergence. “Truly
identical logic used in multiple places _unlikely to diverge_ should be DRYed up”. - **AVOID large bundle-
size increases without discussion:** If a PR adds a heavy dependency (like adding Moment.js or lodash
entire library) just for one feature, consider simpler alternatives or tree-shaking friendly imports. Simplicity
also means not over-burdening the app with things that add complexity in build/performance. In code
review, question if a new lib is worth it or if built-in/browser API or a smaller lib would do. - **AVOID
unmanaged state outside React:** Don’t introduce ad-hoc singletons or module-scoped mutable variables
to share state between components – that breaks React’s model and often leads to hard-to-track bugs. Use
context or state libraries for shared state. The only exception might be some performance critical caching,
but that should be well-encapsulated. E.g., avoid window.myGlobalStore = {} or even imported empty
objects as event buses – use proper patterns instead. - **AVOID leaving console errors/warnings
unresolved:** If using strict mode or TypeScript, any warnings (prop types, act() warnings in tests, etc.)
indicate something to fix. For example, a warning about missing key in list or an uncontrolled to controlled
input warning – these should be addressed in the PR. They often hint at code that might be simplified or
corrected (like properly controlling an input or giving a stable key). Clean console = cleaner code.

**Exceptions:** (Rare cases where above rules might be bent, but should be noted in code or PR) - An any
might be used when interacting with truly dynamic data (e.g., a JSON parser that outputs unknown shape).
In such case, contain the any and convert to known types as soon as possible, and comment why it’s
necessary. - A very simple component might not need explicit prop types if it’s internal – inference could
suffice. But if there’s any doubt, explicit is safer. - You might deliberately duplicate a tiny bit of JSX instead of
abstracting if that abstraction would be premature or make things less clear (as we discussed, sometimes
WET at the outer layer is fine ). Ensure to communicate this in comments: e.g., “Duplicated in X and Y;

```
6
```
```
38
```
```
80
```
```
81
```

abstraction withheld until more use-cases emerge (YAGNI).” - Use of React.memo or useMemo might be
skipped in favor of simplicity if the performance is not an issue. That’s acceptable – measure first.
Premature optimization can make code less simple. So if a reviewer comments “we should memoize this,”
it’s fine to respond with why it’s not needed (but if in doubt, a quick check or adding it if not too intrusive is
okay). - Sometimes a large context might be acceptable if it’s truly app-wide (like a single Redux store or
something). But generally even Redux splits slices, so this is uncommon.

**Example:**

Bad Code (to flag in review):

```
// Anti-pattern example
functionDashboard(props) {
const[data, setData] = useState(); // type implicit any
useEffect(() => {
fetch(props.url).then(res=> res.json()).then(d => setData(d));
}, []); // missing dependency props.url, might bug out
```
```
return<div>
{props.showHeader? <Headeruser={props.user} /> : null}
<Panel>{data? data.map(x=> <Itemkey={x.id} {...x} />) : 'Loading'}</Panel>
<Footer config={props.config} onClick={()=> props.onLogout()} />
{/* onLogout passed through multiple layers, Footer didn't need to be aware
*/}
</div>;
}
```
Issues to point out: - useState() with no initial value or type – should be useState<DataType[] |
null>(null) for example. - Missing dependency in useEffect – should include props.url or better, use
props as input and handle changes. - Direct data fetching in component – consider a custom hook or React
Query. - props.onLogout passed to Footer which presumably just puts a button – maybe Footer could
have its own logic or context for auth. - Footer takes a config prop possibly not needed (if it's global
config, maybe context). - Ternary for header is okay but could use {props.showHeader &&
<Header .../>} shorthand. - Panel usage is okay but Panel children is data or 'Loading' string – mixing
types in children could be problematic (better to have a consistent children type, or handle loading outside
Panel). - data.map(x=> <Item ...>): key is fine, usage of spread might be okay but ensure Item prop
types match (explicit). - The component is doing a lot: data fetch, layout, logout logic, etc.

Good Code (following rules):

```
interfaceDashboardProps{ user: User; showHeader?: boolean; onLogout: () =>
void; }
functionDashboard({ user, showHeader= true, onLogout }: DashboardProps) {
const{ data: items, error, isLoading } = useItems(); // custom hook or
react-query
```

```
return(
<divclassName="dashboard">
{showHeader && <Headeruser={user} />}
<Panel>
{isLoading? (
<Spinner/>
) : error? (
<ErrorMessageerror={error} />
) : (
items!.map(item=> <ItemCardkey={item.id} item={item} />)
)}
</Panel>
<FooteronLogout={onLogout} />
</div>
);
}
```
- Props are typed, with a default for showHeader. - Data fetching abstracted in useItems hook, which
internally might use context or react-query. Simplifies effect management. - Proper loading/error UI
handled. - Footer just takes onLogout directly (no passing through config if not needed). - Overall layout is
clear. If more complexity needed (say Panel header etc.), likely they'd break those out.

**Small Exceptions:** Perhaps Dashboard decided to not use context for items because it’s only used here –
fair. If items were global, maybe context used. Both are fine if justified. The key is it’s simpler and follows
rules (no any, no prop drilling beyond reason, etc.).

By adhering to this ruleset, the team will produce consistent, easy-to-follow code. On code reviews, label
issues with these terms (MUST/SHOULD/AVOID) to indicate severity. Over time, developers internalize these
guidelines, and the codebase stays clean and low in accidental complexity.

By combining solid **principles** , concrete **refactoring techniques** , wise **heuristics** , a step-by-step **playbook** ,
and a strict-but-sensible **code review checklist** , you can systematically simplify React + TypeScript
codebases. The result is code that is easier to read, safer to change, and more fun to work with – which
ultimately leads to a more productive engineering team and more robust applications. With these practices,
you’ll reduce prop drilling pain, tame state complexity, enforce clear boundaries, and make even large
React/TS codebases feel manageable and cohesive. Happy refactoring!

**Sources:** React and TypeScript best practices and expert insights were referenced in compiling this guide,
including community principles on avoiding over-engineering , Kent C. Dodds’s advice on state
management , Shopify’s guidance on server vs client components , and many more. These
ensure the recommendations are grounded in real-world experience and modern React patterns.

```
31 29
4 45 63 62
```

Persson Dennis - 21 Fantastic React
Design Patterns and When to Use Them | Web Development Blog
https://www.perssondennis.com/articles/21-fantastic-react-design-patterns-and-when-to-use-them

What's your opinion on extracting **all** (or most) logic to hooks and letting the
component to the rendering only? : r/reactjs
https://www.reddit.com/r/reactjs/comments/xwzptl/whats_your_opinion_on_extracting_all_or_most/

Application State Management with React
https://kentcdodds.com/blog/application-state-management-with-react

What is Prop Drilling and How to Avoid it? - GeeksforGeeks
https://www.geeksforgeeks.org/reactjs/what-is-prop-drilling-and-how-to-avoid-it/

Rethinking Prop Drilling & State Management in React - DEV Community
https://dev.to/bytebodger/rethinking-prop-drilling-state-management-in-react-1h61

Common Sense Refactoring of a Messy React Component |
Alex Kondov
https://alexkondov.com/refactoring-a-messy-react-component/

How to Avoid Overengineering in Frontend Development | by
Frontend Highlights | Medium
https://medium.com/@ignatovich.dm/how-to-avoid-overengineering-in-frontend-development-a8ef2a501b44

React Code Review Essentials: A Detailed Checklist for Developers - DEV Community
https://dev.to/padmajothi_athimoolam_23d/react-code-review-essentials-a-detailed-checklist-for-developers-20n2

Explicit types vs type inference, and when to use each : r/typescript
https://www.reddit.com/r/typescript/comments/1nq5p16/explicit_types_vs_type_inference_and_when_to_use/

RouteManager UI coding patterns: React - DEV Community
https://dev.to/noriste/routemanager-ui-coding-patterns-react-38df

Mastering Error Boundaries in React | by Jeslur Rahman - Medium
https://medium.com/@jeslurrahman/mastering-error-boundaries-in-react-d6d61a89ce33

Error Boundaries | React TypeScript Cheatsheets
https://react-typescript-cheatsheet.netlify.app/docs/basic/getting-started/error_boundaries/

The Better Way to Type React Components | by Mikael Brevik | Variant
https://blog.variant.no/a-better-way-to-type-react-components-9a6460a1d4b7?gi=312790f910a0

React Server Components Best Practices You Can Use with Hydrogen - Shopify
https://shopify.engineering/react-server-components-best-practices-hydrogen

Mastering React Suspense: Loading States Done Right
https://dev.to/cristiansifuentes/mastering-react-suspense-loading-states-done-right-4083

Common mistakes with React Testing Library
https://kentcdodds.com/blog/common-mistakes-with-react-testing-library

```
1 13 14 16 17 18 19 20 24 25 33 34 53 66 67 76 78 79 80 81
```
```
2 3 21 22 23
```
```
4 5 6 7 44 45 56 57
```
```
8
```
```
9 10 11
```
```
12 46 47 48 49 50 51 52 71 72 73 74 75
```
```
15 28 29 30 31 32 35 36 37 54 55
```
```
26 77
```
```
27
```
```
38 39 40
```
```
41
```
```
42 43
```
```
58 59 60
```
```
61 62 63 64 65
```
```
68
```
```
69 70
```

