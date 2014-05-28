From: =?UTF-8?Q?Martin_=C3=9Cnsal?= <martinunsal@gmail.com>
Subject: Re: Problem with UST related to dlload
Date: Tue, 27 May 2014 17:39:19 -0700
Message-ID: <CACsXv7DV1OCXc9SV9SZp81B2uXoC-iBoH+VfwT6VpoXWc0+Wng__6088.76406117833$1401237627$gmane$org@mail.gmail.com>
References: <CACsXv7BQ-T+6ggdM9+YPcu+hdy0Gxu6c_jxNj97AvzmDgXQ8Wg@mail.gmail.com>
 <CACsXv7Au4yLptJnS5OayD8bqsgbi660bLbJobpczTnnWZbgx=g@mail.gmail.com>
 <53847D18.3060203@keymile.com> <5384A1F4.6080108@mentor.com>
 <5384A409.4090107@keymile.com> <5384A801.8040900@mentor.com>
 <5384B787.8070009@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2020492700=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <martinunsal@gmail.com>) id 1WpRtt-00053q-4x
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 20:39:28 -0400
Received: by mail-vc0-f182.google.com with SMTP id la4so11634642vcb.13
 for <lttng-dev@lists.lttng.org>; Tue, 27 May 2014 17:39:19 -0700 (PDT)
In-Reply-To: <5384B787.8070009@keymile.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Thibault,
 Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

--===============2020492700==
Content-Type: multipart/alternative; boundary=20cf3071cab0fa8f8e04fa6b0a5d

--20cf3071cab0fa8f8e04fa6b0a5d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gerlando, I agree. The __attribute__((weak)) is not strictly necessary in
this case and the problem can be worked around temporarily by removing this
attribute. The reason is that the __start___tracepoints_ptrs and
__stop___tracepoints_ptrs are only being declared, not defined, at
compilation time. There is no need for a weak definition if they are not
defined at all. In fact the definition is provided automagically by the
linker using weak semantics (i.e. only one definition per ELF binary,
shared by all declarations in all compilation units) regardless of the
presence or absence of weak attribute. Since __start___tracepoints_ptrs is
defined by the linker as the starting address of the _tracepoints_ptrs
section, it would be impossible for it to have anything other than weak
semantics, because it is nonsensical for different object files in the same
ELF binary to have different addresses for the same executable section.

Although removing __attribute__((weak)) is successful as a workaround, I
would not recommend to upstream it. Since these symbols have weak
semantics, they should have weak declarations. Removing this attribute
could cause a lot of confusion for people reading the code.

I haven't tried Paul's patch but it also seems like a reasonable local
workaround but not the sort of thing to upstream.

For a long term fix, in my opinion, Yocto/OpenEmbedded needs to fix their
compiler patches.

Martin



On Tue, May 27, 2014 at 9:04 AM, Gerlando Falauto <
gerlando.falauto@keymile.com> wrote:

> Hi Paul,
>
> thanks for your explanation, but I'm more puzzled than ever.
> I'm definitely lacking the appropriate background in both terminology and
> internals, so I tried to figure out how the whole magic works by empirica=
l
> testing.
>
> Now, when you say:
>
>
> > The reason is that you can have the same tracepoint provider be USED in
> > several compilation units that will all become part of one and the same
> > shared object (or executable).
> >
> > Then all those __start/stop___tracepoints_ptrs references in different
> > compilation units should refer to the same
> > __start/stop___tracepoints_ptrs definitions for the shared object (or
> > executable) they are part of. This is required because the
> > initialization of the tracepoints will only happen once per shared
> > object (or executable) with the static ctor mechanism also defined in
> > tracepoint.h
>
> Who's responsible for initializating the tracepoints? Isn't it the
> PROVIDER, instead of the user?
>
> Here's what I understood (or rather, speculated!), so please point out
> where my understanding falls short.
>
> Tracepoint providers (where TRACEPOINT_DEFINE is defined) are what
> actually implement tracepoints. You can have multiple source files, each
> defining one or more tracepoints. So in the end each object file will
> contain one or more tracepoint pointers within its "__tracepoints_ptrs"
> section (courtesy of the compiler). When linking (e.g. towards a shared
> object), a single section __tracepoints_ptrs in the output ELF binary wil=
l
> merge all the sections of the above objects, and hold all the pointers as=
 a
> contiguous array. This time, courtesy of the linker, who also automagical=
ly
> defines __start___tracepoints_ptrs / __stop___tracepoints_ptrs symbols to
> hold pointers to the beginning and end parts of the section.
>
> Each object file will contain its own __tracepoints__ptrs_init()
> constructor, responsible for registering ALL the tracepoints it provides.
> Actually, we want only ONE constructor per shared object to register all
> the tracepoint pointers provided by the whole shared object (contained
> within __start___tracepoints_ptrs/__stop___tracepoints_ptrs). This is
> where, for instance, __tracepoint_ptrs_registered comes into play. Multip=
le
> invocations of the constructor (one per object file) should be avoided an=
d
> only the first one needs to be performed. And this is why
> __tracepoint_ptrs_registered needs to be weak (multiple source files coul=
d
> lead to multiple definitions -- we want one and only one per shared objec=
t)
> *AND* hidden (each shared object should have its own copy).
> If I remove the weak attribute from __tracepoint_ptrs_registered, the
> linker starts screaming as soon as I compile one of the examples.
>
> On the other hand, __start___tracepoints_ptrs/__stop___tracepoints_ptrs
> are generated by the linker (or so I want to believe!) so only one instan=
ce
> is emitted.
> Keeping them hidden prevents the name clash during dynamic linking, as th=
e
> symbol will not be visible from other shared objects or binaries.
> But I don't see why they should also be weak.
>
> As a matter of fact, removing the weak attribute seems to fix my problem
> (as far as I could test).
> What am I missing?
>
> Thank you again for your patience,
> Gerlando
>
>
> On 05/27/2014 04:58 PM, Woegerer, Paul wrote:
>
>> On 05/27/2014 04:41 PM, Gerlando Falauto wrote:
>>
>>> Hi Paul,
>>>
>>> thank you very much for sharing this.
>>>
>>> I had in the meantime run into the same suggestion by
>>> Henrik Wallin on a thread opened by Martin
>>> (https://gcc.gnu.org/ml/gcc-help/2014-05/msg00028.html).
>>> Further updates from Martin also suggest the issue is rather related to
>>> the OpenEmbedded toolchain.
>>>
>>> I was about to post the "opposite" of your patch, as I don't see the
>>> need to have those symbols as weak instead. In the end, doesn't weak
>>> only allow for a further re-definition? In this case we're only
>>> declaring it as extern, aren't we?
>>> Definition actually happens by magic, as far as I can tell.
>>> But please correct me if I got it all wrong.
>>>
>>
>> It's more complicated.
>>
>> You absolutely need those symbol to be declared as:
>>
>>      .weak   __start___tracepoints_ptrs
>>      .weak   __stop___tracepoints_ptrs
>>
>> *and*
>>
>>      .hidden __start___tracepoints_ptrs
>>      .hidden __stop___tracepoints_ptrs
>>
>> The reason is that you can have the same tracepoint provider be USED in
>> several compilation units that will all become part of one and the same
>> shared object (or executable).
>>
>> Then all those __start/stop___tracepoints_ptrs references in different
>> compilation units should refer to the same
>> __start/stop___tracepoints_ptrs definitions for the shared object (or
>> executable) they are part of. This is required because the
>> initialization of the tracepoints will only happen once per shared
>> object (or executable) with the static ctor mechanism also defined in
>> tracepoint.h
>>
>> HTH,
>> Paul
>>
>>
>>> Thank you,
>>> Gerlando
>>>
>>> On 05/27/2014 04:32 PM, Woegerer, Paul wrote:
>>>
>>>> Hi Martin, Hi Gerlando,
>>>>
>>>> this sounds a lot like the compiler bug I found recently in Yocto 1.6
>>>> (reproducible on ARM, x86 and PPC)
>>>>
>>>> The problem in my case is that the Yocto generated GCC cross-compiler
>>>> translates:
>>>>
>>>> extern struct tracepoint * const __start___tracepoints_ptrs[]
>>>>       __attribute__((weak, visibility("hidden")));
>>>> extern struct tracepoint * const __stop___tracepoints_ptrs[]
>>>>       __attribute__((weak, visibility("hidden")));
>>>>
>>>> incorrectly to assembly. For these symbols that are declared with
>>>>
>>>> __attribute__((weak, visibility("hidden")));
>>>>
>>>> that are also defined to be external, in the assembly the following
>>>> lines are missing:
>>>>
>>>> .hidden __stop___tracepoints_ptrs
>>>> .hidden __start___tracepoints_ptrs
>>>>
>>>> This causes __stop___tracepoints_ptrs and __start___tracepoints_ptrs
>>>> to be further treated as ordinary weak symbols instead of
>>>> per-shared-object weak symbols.
>>>> That further will cause  the linker to resolve any such symbols with
>>>> the first definition of those symbols that it can see (it will not
>>>> constrain itself to only consider definitions from within the same
>>>> shared object). The net result is that only one tracepoint provider
>>>> gets activated (the first one the linker sees) instead of all the
>>>> tracepoint providers used in various source files.
>>>>
>>>> To fix this I use the following lttng-ust workaround (for now):
>>>>
>>>> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
>>>> index 66e2abd..50cef26 100644
>>>> --- a/include/lttng/tracepoint.h
>>>> +++ b/include/lttng/tracepoint.h
>>>> @@ -313,9 +313,11 @@ __tracepoints__destroy(void)
>>>>     * (or for the whole main program).
>>>>     */
>>>>    extern struct tracepoint * const __start___tracepoints_ptrs[]
>>>> -       __attribute__((weak, visibility("hidden")));
>>>> +       __attribute__((weak));
>>>> +asm(".hidden __start___tracepoints_ptrs");
>>>>    extern struct tracepoint * const __stop___tracepoints_ptrs[]
>>>> -       __attribute__((weak, visibility("hidden")));
>>>> +       __attribute__((weak));
>>>> +asm(".hidden __stop___tracepoints_ptrs");
>>>>
>>>>    /*
>>>>     * When TRACEPOINT_PROBE_DYNAMIC_LINKAGE is defined, we do not emit
>>>> a
>>>>
>>>>
>>>> Note that this issue is not reproducible with my GCC on host:
>>>> gcc version 4.8.1 20130909 [gcc-4_8-branch revision 202388] (SUSE Linu=
x)
>>>> and also not with the latest Codebench 2014.05 ARM-Linux
>>>> cross-toolchain.
>>>>
>>>> --
>>>> Best,
>>>> Paul
>>>>
>>>> On 05/27/2014 01:55 PM, Gerlando Falauto wrote:
>>>>
>>>>> Hi Martin,
>>>>>
>>>>> I have been struggling for a while with this issue (see the whole
>>>>> thread):
>>>>>
>>>>> http://lists.lttng.org/pipermail/lttng-dev/2014-May/023035.html
>>>>>
>>>>> and landed on the same conclusions as yours (found your message by
>>>>> searching for __start___tracepoints_ptr!).
>>>>> So at least you're not alone!
>>>>>
>>>>> So, did you ever manage to get any of your questions answered:
>>>>>
>>>>>  1) Have you run into a problem like this? Is there a known
>>>>>>>
>>>>>> fix/workaround?
>>>>>
>>>>>> 2) __start____tracepoints_ptrs is declared as extern in tracepoint.h=
,
>>>>>>>
>>>>>> but it
>>>>>
>>>>>> is not defined. This appears to be some sort of undocumented linker
>>>>>>>
>>>>>> magic.
>>>>>
>>>>>> http://gcc.gnu.org/ml/gcc-help/2010-04/msg00120.html is the only
>>>>>>>
>>>>>> reference I
>>>>>
>>>>>> could find. Do you know where this behavior is documented or
>>>>>>>
>>>>>> specified (if
>>>>>
>>>>>> at all)?
>>>>>>> 3) Do you know why the symbol visibility for
>>>>>>> __start___tracepoints_ptrs
>>>>>>> changed between 4.6.4 to 4.7.2?
>>>>>>>
>>>>>>
>>>>> Thank you so much!
>>>>> Gerlando
>>>>>
>>>>> BTW, I'm also running GCC 4.7.2 (lttng-ust is cross-compiled, the tes=
t
>>>>> application is natively compiled).
>>>>>
>>>>> On an x86_64 host running either GCC 4.4.6 or 4.4.7, the issue is not
>>>>> observed.
>>>>>
>>>>>
>>>>> On 04/30/2014 11:57 PM, Martin =C3=9Cnsal wrote:
>>>>>
>>>>>> Incidentally I also asked for help on the GNU linker-specific part
>>>>>> (question 2) here:
>>>>>>
>>>>>> http://gcc.gnu.org/ml/gcc-help/2014-04/msg00164.html
>>>>>>
>>>>>> Martin
>>>>>>
>>>>>>
>>>>>> On Wed, Apr 30, 2014 at 2:21 PM, Martin =C3=9Cnsal <martinunsal@gmai=
l.com>
>>>>>> wrote:
>>>>>>
>>>>>>> Hi LTTng folks
>>>>>>>
>>>>>>> I have a strange problem using LTTng-UST on an ARM based platform. =
I
>>>>>>> have
>>>>>>> done some diagnosis but I am running low on ideas and was hoping fo=
r
>>>>>>> help
>>>>>>> from the experts. I am using lttng-tools 2.2.0, lttng-ust 2.2.0,
>>>>>>> liburcu
>>>>>>> 0.8.1. I know these are old but upgrading is easier said than done
>>>>>>> unfortunately. I didn't see anything related to this problem in
>>>>>>> relnotes,
>>>>>>> mailing list traffic, or master branch, but I could have missed
>>>>>>> something.
>>>>>>>
>>>>>>> The problem showed up when I switched from GCC 4.6.4 to 4.7.2.
>>>>>>> Conceptually,
>>>>>>> the situation is that I have a single executable, call it MyProgram=
,
>>>>>>> with
>>>>>>> two plugins loaded at runtime with dlopen(), lets call them
>>>>>>> libPlugin1.so
>>>>>>> and libPlugin2.so. There are three different LTTng-UST tracepoint
>>>>>>> providers,
>>>>>>> one each for the executable and the two plugins. With GCC 4.7.2,
>>>>>>> tracepoints
>>>>>>> in libPlugin1 stopped working. The tracepoints in MyProgram and in
>>>>>>> libPlugin2 continue to work correctly.
>>>>>>>
>>>>>>> I have established without a doubt that the toolchain upgrade is th=
e
>>>>>>> cause
>>>>>>> of the regression.
>>>>>>>
>>>>>>> In the debugger, I confirmed that the tracepoint for libPlugin1.so =
is
>>>>>>> being
>>>>>>> executed, but __tracepoint_##provider##___##name.state is always 0
>>>>>>> even when
>>>>>>> I enable the tracepoint in lttng-tools. As a result the tracepoint
>>>>>>> callback
>>>>>>> is not being invoked when it should be. In MyProgram and
>>>>>>> libPlugin2.so, the
>>>>>>> .state variable correctly reflects whether the tracepoint is enable=
d,
>>>>>>> and if
>>>>>>> the tracepoint is enabled, the tracepoint callback is invoked.
>>>>>>>
>>>>>>> Next I set a breakpoint in tracepoint_register_lib() and looked at
>>>>>>> tracepoints_start parameter.
>>>>>>>
>>>>>>> 1) With GCC 4.6.4 everything is as expected:
>>>>>>>       a) tracepoint_register_lib() for MyProgram called with
>>>>>>> MyProgramProvider's __start___tracepoints_ptrs.
>>>>>>>       b) tracepoint_register_lib() after libPlugin1 dlopen() called
>>>>>>> with
>>>>>>> libPlugin1Provider's __start___tracepoints_ptrs
>>>>>>>       c) tracepoint_register_lib() after libPlugin2 dlopen() called
>>>>>>> with
>>>>>>> libPlugin2Provider's __start___tracepoint_ptrs
>>>>>>>
>>>>>>> 2) With GCC 4.7.2 there is a problem:
>>>>>>>       a) tracepoint_register_lib() for MyProgram called with
>>>>>>> MyProgramProvider's __start___tracepoints_ptrs.
>>>>>>>       b) tracepoint_register_lib() after libPlugin1 dlopen() called
>>>>>>> with
>>>>>>> MyProgramProvider's __start___tracepoints_ptrs (!!!! THIS IS WRONG
>>>>>>> !!!!)
>>>>>>>       c) tracepoint_register_lib() after libPlugin2 dlopen() called
>>>>>>> with
>>>>>>> libPlugin2Provider's __start___tracepoint_ptrs
>>>>>>>
>>>>>>> I looked at the symbol table for libPlugin1.so to see if it would
>>>>>>> shed some
>>>>>>> light on the problem.
>>>>>>>
>>>>>>> 1) With GCC 4.6.4:
>>>>>>> # objdump -t /usr/lib/.debug/libPlugin1.so | grep
>>>>>>> __start___tracepoints_ptrs
>>>>>>> 00025bb0 l       *ABS* 00000000 __start___tracepoints_ptrs
>>>>>>> # objdump -t /usr/lib/.debug/libPlugin2.so | grep
>>>>>>> __start___tracepoints_ptrs
>>>>>>> 00041eb4 l       *ABS* 00000000 __start___tracepoints_ptrs
>>>>>>>
>>>>>>> 2) With GCC 4.7.2:
>>>>>>> # objdump -t /usr/lib/.debug/libPlugin1.so | grep
>>>>>>> __start___tracepoints_ptrs
>>>>>>> 00025a90 g       __tracepoints_ptrs 00000000
>>>>>>> __start___tracepoints_ptrs
>>>>>>> # objdump -t /usr/lib/.debug/libPlugin2.so | grep
>>>>>>> __start___tracepoints_ptrs
>>>>>>> 00041eb4 g       __tracepoints_ptrs 00000000
>>>>>>> __start___tracepoints_ptrs
>>>>>>>
>>>>>>> My hypothesis at this point is that since __start___tracepoints_ptr=
s
>>>>>>> changed
>>>>>>> from a local to a global symbol, the dynamic loader no longer knows
>>>>>>> how to
>>>>>>> select the correct weak symbol. I cannot explain why libPlugin2 sti=
ll
>>>>>>> loads
>>>>>>> its provider correctly, perhaps it is just getting lucky.
>>>>>>>
>>>>>>> A few questions come to mind...
>>>>>>> 1) Have you run into a problem like this? Is there a known
>>>>>>> fix/workaround?
>>>>>>> 2) __start____tracepoints_ptrs is declared as extern in tracepoint.=
h,
>>>>>>> but it
>>>>>>> is not defined. This appears to be some sort of undocumented linker
>>>>>>> magic.
>>>>>>> http://gcc.gnu.org/ml/gcc-help/2010-04/msg00120.html is the only
>>>>>>> reference I
>>>>>>> could find. Do you know where this behavior is documented or
>>>>>>> specified (if
>>>>>>> at all)?
>>>>>>> 3) Do you know why the symbol visibility for
>>>>>>> __start___tracepoints_ptrs
>>>>>>> changed between 4.6.4 to 4.7.2?
>>>>>>>
>>>>>>> Thanks for any help. This is a real puzzler for me.
>>>>>>>
>>>>>>> Martin
>>>>>>>
>>>>>>>
>>>>>> _______________________________________________
>>>>>> lttng-dev mailing list
>>>>>> lttng-dev@lists.lttng.org
>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>
>>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>
>>>>
>>>>
>>>>
>>>
>>
>>
>

--20cf3071cab0fa8f8e04fa6b0a5d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gerlando, I agree. The __attribute__((weak)) is not strict=
ly necessary in this case and the problem can be worked around temporarily =
by removing this attribute. The reason is that the __start___tracepoints_pt=
rs and __stop___tracepoints_ptrs are only being declared, not defined, at c=
ompilation time. There is no need for a weak definition if they are not def=
ined at all. In fact the definition is provided automagically by the linker=
 using weak semantics (i.e. only one definition per ELF binary, shared by a=
ll declarations in all compilation units) regardless of the presence or abs=
ence of weak attribute. Since __start___tracepoints_ptrs is defined by the =
linker as the starting address of the _tracepoints_ptrs section, it would b=
e impossible for it to have anything other than weak semantics, because it =
is nonsensical for different object files in the same ELF binary to have di=
fferent addresses for the same executable section.<div>
<div><br></div><div>Although removing __attribute__((weak)) is successful a=
s a workaround, I would not recommend to upstream it. Since these symbols h=
ave weak semantics, they should have weak declarations. Removing this attri=
bute could cause a lot of confusion for people reading the code.</div>
<div><br></div><div>I haven&#39;t tried Paul&#39;s patch but it also seems =
like a reasonable local workaround but not the sort of thing to upstream.</=
div><div><br></div><div>For a long term fix, in my opinion, Yocto/OpenEmbed=
ded needs to fix their compiler patches.</div>
<div><br></div><div>Martin</div><div><br></div></div></div><div class=3D"gm=
ail_extra"><br><br><div class=3D"gmail_quote">On Tue, May 27, 2014 at 9:04 =
AM, Gerlando Falauto <span dir=3D"ltr">&lt;<a href=3D"mailto:gerlando.falau=
to@keymile.com" target=3D"_blank">gerlando.falauto@keymile.com</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Paul,<br>
<br>
thanks for your explanation, but I&#39;m more puzzled than ever.<br>
I&#39;m definitely lacking the appropriate background in both terminology a=
nd internals, so I tried to figure out how the whole magic works by empiric=
al testing.<br>
<br>
Now, when you say:<div class=3D""><br>
<br>
&gt; The reason is that you can have the same tracepoint provider be USED i=
n<br>
&gt; several compilation units that will all become part of one and the sam=
e<br>
&gt; shared object (or executable).<br>
&gt;<br>
&gt; Then all those __start/stop___tracepoints_<u></u>ptrs references in di=
fferent<br>
&gt; compilation units should refer to the same<br>
&gt; __start/stop___tracepoints_<u></u>ptrs definitions for the shared obje=
ct (or<br>
&gt; executable) they are part of. This is required because the<br>
&gt; initialization of the tracepoints will only happen once per shared<br>
&gt; object (or executable) with the static ctor mechanism also defined in<=
br>
&gt; tracepoint.h<br>
<br></div>
Who&#39;s responsible for initializating the tracepoints? Isn&#39;t it the =
PROVIDER, instead of the user?<br>
<br>
Here&#39;s what I understood (or rather, speculated!), so please point out =
where my understanding falls short.<br>
<br>
Tracepoint providers (where TRACEPOINT_DEFINE is defined) are what actually=
 implement tracepoints. You can have multiple source files, each defining o=
ne or more tracepoints. So in the end each object file will contain one or =
more tracepoint pointers within its &quot;__tracepoints_ptrs&quot; section =
(courtesy of the compiler). When linking (e.g. towards a shared object), a =
single section __tracepoints_ptrs in the output ELF binary will merge all t=
he sections of the above objects, and hold all the pointers as a contiguous=
 array. This time, courtesy of the linker, who also automagically defines _=
_start___tracepoints_ptrs / __stop___tracepoints_ptrs symbols to hold point=
ers to the beginning and end parts of the section.<br>

<br>
Each object file will contain its own __tracepoints__ptrs_init() constructo=
r, responsible for registering ALL the tracepoints it provides. Actually, w=
e want only ONE constructor per shared object to register all the tracepoin=
t pointers provided by the whole shared object (contained within __start___=
tracepoints_ptrs/__<u></u>stop___tracepoints_ptrs). This is where, for inst=
ance, __tracepoint_ptrs_registered comes into play. Multiple invocations of=
 the constructor (one per object file) should be avoided and only the first=
 one needs to be performed. And this is why __tracepoint_ptrs_registered ne=
eds to be weak (multiple source files could lead to multiple definitions --=
 we want one and only one per shared object) *AND* hidden (each shared obje=
ct should have its own copy).<br>

If I remove the weak attribute from __tracepoint_ptrs_registered, the linke=
r starts screaming as soon as I compile one of the examples.<br>
<br>
On the other hand, __start___tracepoints_ptrs/__<u></u>stop___tracepoints_p=
trs are generated by the linker (or so I want to believe!) so only one inst=
ance is emitted.<br>
Keeping them hidden prevents the name clash during dynamic linking, as the =
symbol will not be visible from other shared objects or binaries.<br>
But I don&#39;t see why they should also be weak.<br>
<br>
As a matter of fact, removing the weak attribute seems to fix my problem (a=
s far as I could test).<br>
What am I missing?<br>
<br>
Thank you again for your patience,<br>
Gerlando<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On 05/27/2014 04:58 PM, Woegerer, Paul wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 05/27/2014 04:41 PM, Gerlando Falauto wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Paul,<br>
<br>
thank you very much for sharing this.<br>
<br>
I had in the meantime run into the same suggestion by<br>
Henrik Wallin on a thread opened by Martin<br>
(<a href=3D"https://gcc.gnu.org/ml/gcc-help/2014-05/msg00028.html" target=
=3D"_blank">https://gcc.gnu.org/ml/gcc-<u></u>help/2014-05/msg00028.html</a=
>).<br>
Further updates from Martin also suggest the issue is rather related to<br>
the OpenEmbedded toolchain.<br>
<br>
I was about to post the &quot;opposite&quot; of your patch, as I don&#39;t =
see the<br>
need to have those symbols as weak instead. In the end, doesn&#39;t weak<br=
>
only allow for a further re-definition? In this case we&#39;re only<br>
declaring it as extern, aren&#39;t we?<br>
Definition actually happens by magic, as far as I can tell.<br>
But please correct me if I got it all wrong.<br>
</blockquote>
<br>
It&#39;s more complicated.<br>
<br>
You absolutely need those symbol to be declared as:<br>
<br>
=C2=A0 =C2=A0 =C2=A0.weak =C2=A0 __start___tracepoints_ptrs<br>
=C2=A0 =C2=A0 =C2=A0.weak =C2=A0 __stop___tracepoints_ptrs<br>
<br>
*and*<br>
<br>
=C2=A0 =C2=A0 =C2=A0.hidden __start___tracepoints_ptrs<br>
=C2=A0 =C2=A0 =C2=A0.hidden __stop___tracepoints_ptrs<br>
<br>
The reason is that you can have the same tracepoint provider be USED in<br>
several compilation units that will all become part of one and the same<br>
shared object (or executable).<br>
<br>
Then all those __start/stop___tracepoints_<u></u>ptrs references in differe=
nt<br>
compilation units should refer to the same<br>
__start/stop___tracepoints_<u></u>ptrs definitions for the shared object (o=
r<br>
executable) they are part of. This is required because the<br>
initialization of the tracepoints will only happen once per shared<br>
object (or executable) with the static ctor mechanism also defined in<br>
tracepoint.h<br>
<br>
HTH,<br>
Paul<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Thank you,<br>
Gerlando<br>
<br>
On 05/27/2014 04:32 PM, Woegerer, Paul wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Martin, Hi Gerlando,<br>
<br>
this sounds a lot like the compiler bug I found recently in Yocto 1.6<br>
(reproducible on ARM, x86 and PPC)<br>
<br>
The problem in my case is that the Yocto generated GCC cross-compiler<br>
translates:<br>
<br>
extern struct tracepoint * const __start___tracepoints_ptrs[]<br>
=C2=A0 =C2=A0 =C2=A0 __attribute__((weak, visibility(&quot;hidden&quot;)));=
<br>
extern struct tracepoint * const __stop___tracepoints_ptrs[]<br>
=C2=A0 =C2=A0 =C2=A0 __attribute__((weak, visibility(&quot;hidden&quot;)));=
<br>
<br>
incorrectly to assembly. For these symbols that are declared with<br>
<br>
__attribute__((weak, visibility(&quot;hidden&quot;)));<br>
<br>
that are also defined to be external, in the assembly the following<br>
lines are missing:<br>
<br>
.hidden __stop___tracepoints_ptrs<br>
.hidden __start___tracepoints_ptrs<br>
<br>
This causes __stop___tracepoints_ptrs and __start___tracepoints_ptrs<br>
to be further treated as ordinary weak symbols instead of<br>
per-shared-object weak symbols.<br>
That further will cause =C2=A0the linker to resolve any such symbols with<b=
r>
the first definition of those symbols that it can see (it will not<br>
constrain itself to only consider definitions from within the same<br>
shared object). The net result is that only one tracepoint provider<br>
gets activated (the first one the linker sees) instead of all the<br>
tracepoint providers used in various source files.<br>
<br>
To fix this I use the following lttng-ust workaround (for now):<br>
<br>
diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h<br>
index 66e2abd..50cef26 100644<br>
--- a/include/lttng/tracepoint.h<br>
+++ b/include/lttng/tracepoint.h<br>
@@ -313,9 +313,11 @@ __tracepoints__destroy(void)<br>
=C2=A0 =C2=A0 * (or for the whole main program).<br>
=C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0extern struct tracepoint * const __start___tracepoints_ptrs[]<=
br>
- =C2=A0 =C2=A0 =C2=A0 __attribute__((weak, visibility(&quot;hidden&quot;))=
);<br>
+ =C2=A0 =C2=A0 =C2=A0 __attribute__((weak));<br>
+asm(&quot;.hidden __start___tracepoints_ptrs&quot;);<br>
=C2=A0 =C2=A0extern struct tracepoint * const __stop___tracepoints_ptrs[]<b=
r>
- =C2=A0 =C2=A0 =C2=A0 __attribute__((weak, visibility(&quot;hidden&quot;))=
);<br>
+ =C2=A0 =C2=A0 =C2=A0 __attribute__((weak));<br>
+asm(&quot;.hidden __stop___tracepoints_ptrs&quot;);<br>
<br>
=C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 * When TRACEPOINT_PROBE_DYNAMIC_<u></u>LINKAGE is defined, we=
 do not emit a<br>
<br>
<br>
Note that this issue is not reproducible with my GCC on host:<br>
gcc version 4.8.1 20130909 [gcc-4_8-branch revision 202388] (SUSE Linux)<br=
>
and also not with the latest Codebench 2014.05 ARM-Linux cross-toolchain.<b=
r>
<br>
--<br>
Best,<br>
Paul<br>
<br>
On 05/27/2014 01:55 PM, Gerlando Falauto wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Martin,<br>
<br>
I have been struggling for a while with this issue (see the whole<br>
thread):<br>
<br>
<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2014-May/023035.html"=
 target=3D"_blank">http://lists.lttng.org/<u></u>pipermail/lttng-dev/2014-M=
ay/<u></u>023035.html</a><br>
<br>
and landed on the same conclusions as yours (found your message by<br>
searching for __start___tracepoints_ptr!).<br>
So at least you&#39;re not alone!<br>
<br>
So, did you ever manage to get any of your questions answered:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
1) Have you run into a problem like this? Is there a known<br>
</blockquote></blockquote>
fix/workaround?<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
2) __start____tracepoints_ptrs is declared as extern in tracepoint.h,<br>
</blockquote></blockquote>
but it<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
is not defined. This appears to be some sort of undocumented linker<br>
</blockquote></blockquote>
magic.<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<a href=3D"http://gcc.gnu.org/ml/gcc-help/2010-04/msg00120.html" target=3D"=
_blank">http://gcc.gnu.org/ml/gcc-<u></u>help/2010-04/msg00120.html</a> is =
the only<br>
</blockquote></blockquote>
reference I<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
could find. Do you know where this behavior is documented or<br>
</blockquote></blockquote>
specified (if<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
at all)?<br>
3) Do you know why the symbol visibility for<br>
__start___tracepoints_ptrs<br>
changed between 4.6.4 to 4.7.2?<br>
</blockquote></blockquote>
<br>
Thank you so much!<br>
Gerlando<br>
<br>
BTW, I&#39;m also running GCC 4.7.2 (lttng-ust is cross-compiled, the test<=
br>
application is natively compiled).<br>
<br>
On an x86_64 host running either GCC 4.4.6 or 4.4.7, the issue is not<br>
observed.<br>
<br>
<br>
On 04/30/2014 11:57 PM, Martin =C3=9Cnsal wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Incidentally I also asked for help on the GNU linker-specific part<br>
(question 2) here:<br>
<br>
<a href=3D"http://gcc.gnu.org/ml/gcc-help/2014-04/msg00164.html" target=3D"=
_blank">http://gcc.gnu.org/ml/gcc-<u></u>help/2014-04/msg00164.html</a><br>
<br>
Martin<br>
<br>
<br>
On Wed, Apr 30, 2014 at 2:21 PM, Martin =C3=9Cnsal &lt;<a href=3D"mailto:ma=
rtinunsal@gmail.com" target=3D"_blank">martinunsal@gmail.com</a>&gt;<br>
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi LTTng folks<br>
<br>
I have a strange problem using LTTng-UST on an ARM based platform. I<br>
have<br>
done some diagnosis but I am running low on ideas and was hoping for<br>
help<br>
from the experts. I am using lttng-tools 2.2.0, lttng-ust 2.2.0,<br>
liburcu<br>
0.8.1. I know these are old but upgrading is easier said than done<br>
unfortunately. I didn&#39;t see anything related to this problem in<br>
relnotes,<br>
mailing list traffic, or master branch, but I could have missed<br>
something.<br>
<br>
The problem showed up when I switched from GCC 4.6.4 to 4.7.2.<br>
Conceptually,<br>
the situation is that I have a single executable, call it MyProgram,<br>
with<br>
two plugins loaded at runtime with dlopen(), lets call them<br>
libPlugin1.so<br>
and libPlugin2.so. There are three different LTTng-UST tracepoint<br>
providers,<br>
one each for the executable and the two plugins. With GCC 4.7.2,<br>
tracepoints<br>
in libPlugin1 stopped working. The tracepoints in MyProgram and in<br>
libPlugin2 continue to work correctly.<br>
<br>
I have established without a doubt that the toolchain upgrade is the<br>
cause<br>
of the regression.<br>
<br>
In the debugger, I confirmed that the tracepoint for libPlugin1.so is<br>
being<br>
executed, but __tracepoint_##provider##___##<u></u>name.state is always 0<b=
r>
even when<br>
I enable the tracepoint in lttng-tools. As a result the tracepoint<br>
callback<br>
is not being invoked when it should be. In MyProgram and<br>
libPlugin2.so, the<br>
.state variable correctly reflects whether the tracepoint is enabled,<br>
and if<br>
the tracepoint is enabled, the tracepoint callback is invoked.<br>
<br>
Next I set a breakpoint in tracepoint_register_lib() and looked at<br>
tracepoints_start parameter.<br>
<br>
1) With GCC 4.6.4 everything is as expected:<br>
=C2=A0 =C2=A0 =C2=A0 a) tracepoint_register_lib() for MyProgram called with=
<br>
MyProgramProvider&#39;s __start___tracepoints_ptrs.<br>
=C2=A0 =C2=A0 =C2=A0 b) tracepoint_register_lib() after libPlugin1 dlopen()=
 called<br>
with<br>
libPlugin1Provider&#39;s __start___tracepoints_ptrs<br>
=C2=A0 =C2=A0 =C2=A0 c) tracepoint_register_lib() after libPlugin2 dlopen()=
 called<br>
with<br>
libPlugin2Provider&#39;s __start___tracepoint_ptrs<br>
<br>
2) With GCC 4.7.2 there is a problem:<br>
=C2=A0 =C2=A0 =C2=A0 a) tracepoint_register_lib() for MyProgram called with=
<br>
MyProgramProvider&#39;s __start___tracepoints_ptrs.<br>
=C2=A0 =C2=A0 =C2=A0 b) tracepoint_register_lib() after libPlugin1 dlopen()=
 called<br>
with<br>
MyProgramProvider&#39;s __start___tracepoints_ptrs (!!!! THIS IS WRONG<br>
!!!!)<br>
=C2=A0 =C2=A0 =C2=A0 c) tracepoint_register_lib() after libPlugin2 dlopen()=
 called<br>
with<br>
libPlugin2Provider&#39;s __start___tracepoint_ptrs<br>
<br>
I looked at the symbol table for libPlugin1.so to see if it would<br>
shed some<br>
light on the problem.<br>
<br>
1) With GCC 4.6.4:<br>
# objdump -t /usr/lib/.debug/libPlugin1.so | grep<br>
__start___tracepoints_ptrs<br>
00025bb0 l =C2=A0 =C2=A0 =C2=A0 *ABS* 00000000 __start___tracepoints_ptrs<b=
r>
# objdump -t /usr/lib/.debug/libPlugin2.so | grep<br>
__start___tracepoints_ptrs<br>
00041eb4 l =C2=A0 =C2=A0 =C2=A0 *ABS* 00000000 __start___tracepoints_ptrs<b=
r>
<br>
2) With GCC 4.7.2:<br>
# objdump -t /usr/lib/.debug/libPlugin1.so | grep<br>
__start___tracepoints_ptrs<br>
00025a90 g =C2=A0 =C2=A0 =C2=A0 __tracepoints_ptrs 00000000<br>
__start___tracepoints_ptrs<br>
# objdump -t /usr/lib/.debug/libPlugin2.so | grep<br>
__start___tracepoints_ptrs<br>
00041eb4 g =C2=A0 =C2=A0 =C2=A0 __tracepoints_ptrs 00000000<br>
__start___tracepoints_ptrs<br>
<br>
My hypothesis at this point is that since __start___tracepoints_ptrs<br>
changed<br>
from a local to a global symbol, the dynamic loader no longer knows<br>
how to<br>
select the correct weak symbol. I cannot explain why libPlugin2 still<br>
loads<br>
its provider correctly, perhaps it is just getting lucky.<br>
<br>
A few questions come to mind...<br>
1) Have you run into a problem like this? Is there a known<br>
fix/workaround?<br>
2) __start____tracepoints_ptrs is declared as extern in tracepoint.h,<br>
but it<br>
is not defined. This appears to be some sort of undocumented linker<br>
magic.<br>
<a href=3D"http://gcc.gnu.org/ml/gcc-help/2010-04/msg00120.html" target=3D"=
_blank">http://gcc.gnu.org/ml/gcc-<u></u>help/2010-04/msg00120.html</a> is =
the only<br>
reference I<br>
could find. Do you know where this behavior is documented or<br>
specified (if<br>
at all)?<br>
3) Do you know why the symbol visibility for<br>
__start___tracepoints_ptrs<br>
changed between 4.6.4 to 4.7.2?<br>
<br>
Thanks for any help. This is a real puzzler for me.<br>
<br>
Martin<br>
<br>
</blockquote>
<br>
______________________________<u></u>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-<u></u>bin/mailman/listinfo/lttng-d=
ev</a><br>
<br>
</blockquote>
<br>
<br>
______________________________<u></u>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-<u></u>bin/mailman/listinfo/lttng-d=
ev</a><br>
</blockquote>
<br>
<br>
</blockquote>
<br>
</blockquote>
<br>
<br>
</blockquote>
<br>
</div></div></blockquote></div><br></div>

--20cf3071cab0fa8f8e04fa6b0a5d--


--===============2020492700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2020492700==--
