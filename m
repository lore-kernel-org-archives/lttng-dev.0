From: Brian Rossa <br@f0cal.com>
Subject: Re: "Hands-free" tracepoints using LD_PRELOAD
Date: Tue, 22 Jan 2019 13:30:23 -0500
Message-ID: <CAF=ZobwMe56-9nb+o=jYcpJVuhxEsHthLCHrkFt8KhEaK5bODQ__22709.55841975$1548183065$gmane$org@mail.gmail.com>
References: <CAF=ZobxSoNuto2U9NTihytCpdNODfH8Bv6JtGCym_g6hg3Uz4w@mail.gmail.com>
 <CADcCL0gLBOs1L0sqOsPg3+nyHp0sVFGK2ymk0-pw4QRGO7UhGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7725566007153668272=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 43kcRj10byznNc
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 13:30:40 -0500 (EST)
Received: by mail-lj1-x22b.google.com with SMTP id s5-v6so21492216ljd.12
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 10:30:40 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41])
 by smtp.gmail.com with ESMTPSA id 11-v6sm124163ljv.1.2019.01.22.10.30.36
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 10:30:37 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id e26so18846663lfc.2
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 10:30:36 -0800 (PST)
In-Reply-To: <CADcCL0gLBOs1L0sqOsPg3+nyHp0sVFGK2ymk0-pw4QRGO7UhGw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7725566007153668272==
Content-Type: multipart/alternative; boundary="000000000000639fba0580102c4f"

--000000000000639fba0580102c4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Francis,

Thanks for your detailed, helpful reply. I was especially excited to learn
about the progress on `--userspace-probe`, but unfortunately I *do* need to
extract the function arguments. It would seem, then, that interposition
through LD_PRELOAD is really the only option. The decision to port to LTTng
or not would just come down to how easy it was to generate all the required
boilerplate.

Here's a little more about my application:

   1. The whitelist is composed of mangled names that the user can extract
   from the target object with the standard `nm` workflow.
   2. Each mangled name in the whitelist gets demangled and parsed into
   `prefix`, `callable_name`, `argument_types`, etc.
   3. The list of `argument_types` is compared to the "extra annotation" I
   alluded to. This extra annotation is just a one-to-one map between argum=
ent
   type names and the names of structs that corresponding variables should =
be
   wrapped with before passing them to the logger. These structs just provi=
de
   custom ostream operators for types that don't log nicely otherwise.
   4. Boilerplate that does the typical `log(...); auto return_val =3D
   dlsym(...); log(...); return return_val;` gets generated.
   5. `log(...)` is a thin interface to spdlog
   <https://github.com/gabime/spdlog> that handles `__attribute__`-based
   setup and teardown of a logger.

So at the end of the day, the shim developer provides:

   - The whitelist of mangled names
   - Implementations of struct "wrappers" that provide custom ostream
   operators
   - A map between type names and wrapper names

The machinery here seems fairly general-purpose, but I don't presume to be
an expert. My implementation is somewhat error-prone, and my main hope in
reaching out to the mailing list was that LTTng already had some of these
steps better-implemented. Step #2 is particularly problematic due to
ambiguities in the mangling grammar, and will need support going forward to
generalize well.

I would be happy to contribute some or all of my implementation if it's
something that the LTTng community would be interested in supporting and
extending.

Cheers!
~br

On Tue, Jan 22, 2019 at 12:16 PM Francis Deslauriers <
francis.deslauriers@efficios.com> wrote:

> Hi Brian,
> If I understand correctly, you want developers to provide a whitelist
> of functions that they want to instrument in an arbitrary shared
> library, and then have a system that instruments those functions
> without having to recompile the library with LTTng-UST tracepoints.
> Can you give us an example of annotation that the shim developer would
> provide?
> Do you need to support the extraction of function arguments? If you
> don't, here are two straightforward and tested approaches to solve
> your problem:
>
> First, overriding target symbols using LD_PRELOAD (like you suggested
> above):
> 1. Create boilerplate script #1 that generates tracepoints definitions
> [1] based on function name,
> 2. Create boilerplate script #2 that generates a function calling the
> right tracepoint and the original target function [2],
> 3. For each target symbol "bar", using script #1, create a tracepoint
> definition "libfoo:bar_tp", and compile them into a tracepoints.o.
> object file,
> 4. For each target symbol "bar", using script #2, create a function
> "bar" that calls the bar_tp tracepoint (e.g. tracepoint(libfoo,
> bar_tp) ) and then calls the original bar function in libfoo.so (using
> dlsym(3)), and compile those callsites into a callsites.o object file,
> 5. Create a shared library libshim.so using tracepoints.o and
> callsites.o object files and link it to lttng-ust lib and the dynamic
> loader lib using :"-llttng-ust -ldl",
> Those steps results in the creation of a libshim.so file that contains
> the "bar" overriding function (containing the tracepoint callsite)
> that will be called instead of "bar" function in the libfoo.so library
> when LD_PRELOADing it (e.g. LD_PRELOAD=3Dlibshim.so ./fooapp). Here is
> the Makefile I used to test this [3] to give you a sense of the
> pipeline.
>
> Second, using the newly added --userspace-probe instrumentation:
> This option allows you to instrument any ELF symbol without
> recompiling or restarting the target process.
> For example, to instrument the "bar" function in the /tmp/libfoo.so
> file you could run to following command:
>     > lttng enable-event -k --userspace-probe=3D"elf:/tmp/libfoo.so:bar"
> $event_name
> You could write a script that takes the list of target functions and
> adds userspace-probes on each of them.
> This approach has the advantage that you can also instrument functions
> in the binary and not only functions in shared libraries.
> This instrumentation type uses the kernel tracer and thus requires
> using the lttng-modules.
>
> If you do need to save the function arguments, I believe it's possible
> using the first approach, by tweaking the two boilerplate scripts
> depending on what are the annotations you want to provide.
> Supporting argument extraction with userspace-probes is part of our
> long term goal and would be a really powerful feature but will require
> a significant engineering effort to accomplish.
>
> [1] : https://lttng.org/docs/v2.10/#doc-tpp-header
> [2]: https://lttng.org/docs/v2.10/#doc-probing-the-application-source-cod=
e
> [3]: http://paste.ubuntu.com/p/5fBSgRqXsB/
>
> I hope this make sense. Please don't hesitate if you want more details.
>
> Thank you,
> Francis
>
> Le ven. 18 janv. 2019, =C3=A0 16 h 04, Brian Rossa <br@f0cal.com> a =C3=
=A9crit :
> >
> > Hello,
> >
> > I have a custom tracing solution that I'm interested in porting to
> LTTng. It works as follows:
> >
> > Input is a whitelist of mangled names taken from a target library,
> libfoo.so.
> > For each name, generate a logging shim (example) for the corresponding
> call.
> > Compile all the logging shims into a shared library, libshim.so.
> > Trace any application using libfoo by running it as
> LD_PRELOAD=3Dlibshim.so ./fooapp
> >
> > There are two nice things about this approach that I would like to
> preserve:
> >
> > The shim developer only needs to provide the whitelist and a bit of
> extra annotation. From there, the shim can be be authored using a
> boilerplate generator.
> > The app developer doesn't have to do anything other than pass the
> LD_PRELOAD flag.
> >
> > The downside is that the only tracepoints are those corresponding to th=
e
> whitelist, but I'm fine with that.
> >
> > Can this kind of "hands-free" developer experience be supported by LTTn=
g?
> >
> > Thanks!
> > ~br
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> --
> Francis Deslauriers
> Computer Engineer
> EfficiOS inc.
>

--000000000000639fba0580102c4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Francis,</div><div><br></div><div>Thanks for your det=
ailed, helpful reply. I was especially excited to learn about the progress =
on `--userspace-probe`, but unfortunately I *do* need to extract the functi=
on arguments. It would seem, then, that interposition through LD_PRELOAD is=
 really the only option. The decision to port to LTTng or not would just co=
me down to how easy it was to generate all the required boilerplate.<br></d=
iv><div><br></div><div>Here&#39;s a little more about my application:</div>=
<div><ol><li>The whitelist is composed of mangled names that the user can e=
xtract from the target object with the standard `nm` workflow.</li><li>Each=
 mangled name in the whitelist gets demangled and parsed into `prefix`, `ca=
llable_name`, `argument_types`, etc.</li><li>The list of `argument_types` i=
s compared to the &quot;extra annotation&quot; I alluded to. This extra ann=
otation is just a one-to-one map between argument type names and the names =
of structs that corresponding variables should be wrapped with before passi=
ng them to the logger. These structs just provide custom ostream operators =
for types that don&#39;t log nicely otherwise.<br></li><li>Boilerplate that=
 does the typical `log(...); auto return_val =3D dlsym(...); log(...); retu=
rn return_val;` gets generated.<br></li><li>`log(...)` is a thin interface =
to <a href=3D"https://github.com/gabime/spdlog">spdlog</a> that handles `__=
attribute__`-based setup and teardown of a logger.</li></ol><div>So at the =
end of the day, the shim developer provides:</div><div><ul><li>The whitelis=
t of mangled names</li><li>Implementations of struct &quot;wrappers&quot; t=
hat provide custom ostream operators</li><li>A map between type names and w=
rapper names<br></li></ul></div><div>The machinery here seems fairly genera=
l-purpose, but I don&#39;t presume to be an expert. My implementation is so=
mewhat error-prone, and my main hope in reaching out to the mailing list wa=
s that LTTng already had some of these steps better-implemented. Step #2 is=
 particularly problematic due to ambiguities in the mangling grammar, and w=
ill need support going forward to generalize well.=C2=A0</div><div><br></di=
v><div>I would be happy to contribute some or all of my implementation if i=
t&#39;s something that the LTTng community would be interested in supportin=
g and extending.</div><div><br></div><div>Cheers!</div><div>~br</div></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Tue, Jan 22, 2019 at 12:16 PM Francis Deslauriers &lt;<a href=3D"mailto:=
francis.deslauriers@efficios.com">francis.deslauriers@efficios.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">Hi Brian,<br>
If I understand correctly, you want developers to provide a whitelist<br>
of functions that they want to instrument in an arbitrary shared<br>
library, and then have a system that instruments those functions<br>
without having to recompile the library with LTTng-UST tracepoints.<br>
Can you give us an example of annotation that the shim developer would<br>
provide?<br>
Do you need to support the extraction of function arguments? If you<br>
don&#39;t, here are two straightforward and tested approaches to solve<br>
your problem:<br>
<br>
First, overriding target symbols using LD_PRELOAD (like you suggested above=
):<br>
1. Create boilerplate script #1 that generates tracepoints definitions<br>
[1] based on function name,<br>
2. Create boilerplate script #2 that generates a function calling the<br>
right tracepoint and the original target function [2],<br>
3. For each target symbol &quot;bar&quot;, using script #1, create a tracep=
oint<br>
definition &quot;libfoo:bar_tp&quot;, and compile them into a tracepoints.o=
.<br>
object file,<br>
4. For each target symbol &quot;bar&quot;, using script #2, create a functi=
on<br>
&quot;bar&quot; that calls the bar_tp tracepoint (e.g. tracepoint(libfoo,<b=
r>
bar_tp) ) and then calls the original bar function in libfoo.so (using<br>
dlsym(3)), and compile those callsites into a callsites.o object file,<br>
5. Create a shared library libshim.so using tracepoints.o and<br>
callsites.o object files and link it to lttng-ust lib and the dynamic<br>
loader lib using :&quot;-llttng-ust -ldl&quot;,<br>
Those steps results in the creation of a libshim.so file that contains<br>
the &quot;bar&quot; overriding function (containing the tracepoint callsite=
)<br>
that will be called instead of &quot;bar&quot; function in the libfoo.so li=
brary<br>
when LD_PRELOADing it (e.g. LD_PRELOAD=3Dlibshim.so ./fooapp). Here is<br>
the Makefile I used to test this [3] to give you a sense of the<br>
pipeline.<br>
<br>
Second, using the newly added --userspace-probe instrumentation:<br>
This option allows you to instrument any ELF symbol without<br>
recompiling or restarting the target process.<br>
For example, to instrument the &quot;bar&quot; function in the /tmp/libfoo.=
so<br>
file you could run to following command:<br>
=C2=A0 =C2=A0 &gt; lttng enable-event -k --userspace-probe=3D&quot;elf:/tmp=
/libfoo.so:bar&quot;<br>
$event_name<br>
You could write a script that takes the list of target functions and<br>
adds userspace-probes on each of them.<br>
This approach has the advantage that you can also instrument functions<br>
in the binary and not only functions in shared libraries.<br>
This instrumentation type uses the kernel tracer and thus requires<br>
using the lttng-modules.<br>
<br>
If you do need to save the function arguments, I believe it&#39;s possible<=
br>
using the first approach, by tweaking the two boilerplate scripts<br>
depending on what are the annotations you want to provide.<br>
Supporting argument extraction with userspace-probes is part of our<br>
long term goal and would be a really powerful feature but will require<br>
a significant engineering effort to accomplish.<br>
<br>
[1] : <a href=3D"https://lttng.org/docs/v2.10/#doc-tpp-header" rel=3D"noref=
errer" target=3D"_blank">https://lttng.org/docs/v2.10/#doc-tpp-header</a><b=
r>
[2]: <a href=3D"https://lttng.org/docs/v2.10/#doc-probing-the-application-s=
ource-code" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.=
10/#doc-probing-the-application-source-code</a><br>
[3]: <a href=3D"http://paste.ubuntu.com/p/5fBSgRqXsB/" rel=3D"noreferrer" t=
arget=3D"_blank">http://paste.ubuntu.com/p/5fBSgRqXsB/</a><br>
<br>
I hope this make sense. Please don&#39;t hesitate if you want more details.=
<br>
<br>
Thank you,<br>
Francis<br>
<br>
Le ven. 18 janv. 2019, =C3=A0 16 h 04, Brian Rossa &lt;<a href=3D"mailto:br=
@f0cal.com" target=3D"_blank">br@f0cal.com</a>&gt; a =C3=A9crit :<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; I have a custom tracing solution that I&#39;m interested in porting to=
 LTTng. It works as follows:<br>
&gt;<br>
&gt; Input is a whitelist of mangled names taken from a target library, lib=
foo.so.<br>
&gt; For each name, generate a logging shim (example) for the corresponding=
 call.<br>
&gt; Compile all the logging shims into a shared library, libshim.so.<br>
&gt; Trace any application using libfoo by running it as LD_PRELOAD=3Dlibsh=
im.so ./fooapp<br>
&gt;<br>
&gt; There are two nice things about this approach that I would like to pre=
serve:<br>
&gt;<br>
&gt; The shim developer only needs to provide the whitelist and a bit of ex=
tra annotation. From there, the shim can be be authored using a boilerplate=
 generator.<br>
&gt; The app developer doesn&#39;t have to do anything other than pass the =
LD_PRELOAD flag.<br>
&gt;<br>
&gt; The downside is that the only tracepoints are those corresponding to t=
he whitelist, but I&#39;m fine with that.<br>
&gt;<br>
&gt; Can this kind of &quot;hands-free&quot; developer experience be suppor=
ted by LTTng?<br>
&gt;<br>
&gt; Thanks!<br>
&gt; ~br<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
<br>
<br>
--<br>
Francis Deslauriers<br>
Computer Engineer<br>
EfficiOS inc.<br>
</blockquote></div>

--000000000000639fba0580102c4f--

--===============7725566007153668272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7725566007153668272==--
