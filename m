From: craig harmer <charmster@gmail.com>
Subject: Re: porting LTTng to Go(lang)?
Date: Fri, 2 Jun 2017 19:24:37 -0700
Message-ID: <CADjtVta3FFsAvk-rOaChb0rQs9_UzBUZ3K7ZX++aoKhqiRXWCA__7491.77517504922$1496457502$gmane$org@mail.gmail.com>
References: <CADjtVtYQ2M_j=CnPrjP81ECZKa1vzfE-xJ5QnEkDhaT+uk=9cg@mail.gmail.com>
 <1949609462.4236.1496419081125.JavaMail.zimbra@efficios.com>
 <CAB4xu_00+eFuXmod=GsS+rHs4Do1WwS5DYRsX4u8PdRGr6zpvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4633950577094324889=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 by lists.lttng.org (Postfix) with ESMTPS id 3wflLf0spnz1253
 for <lttng-dev@lists.lttng.org>; Sat,  3 Jun 2017 02:26:01 +0000 (UTC)
Received: by mail-wm0-x230.google.com with SMTP id d127so38859933wmf.0
 for <lttng-dev@lists.lttng.org>; Fri, 02 Jun 2017 19:24:39 -0700 (PDT)
In-Reply-To: <CAB4xu_00+eFuXmod=GsS+rHs4Do1WwS5DYRsX4u8PdRGr6zpvg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4633950577094324889==
Content-Type: multipart/alternative; boundary="001a114e254ab61f2e055104f89e"

--001a114e254ab61f2e055104f89e
Content-Type: text/plain; charset="UTF-8"

hi all,

the suggestion to write a pre-processor for LTTng tracepoints is
interesting and may be a good idea.  however, i'm not sure that it will
provide a general purpose solution.

the problem i for see is that tracepoint invocations, at least, should be
written in the syntax of the language they're being used in (a programmer
would would expect the tracepoint() function call to look like any other
function call in the language).

so the tracepoint parser needs to understand the function invocation syntax
of each language.  it also needs to understand at least some of the rest of
the syntax of the language -- in the case of Go it at least needs to be
able recognize "import" statements and import those files and it needs to
understand when something that looks like a tracepoint() is actually
embedded in a comment or string.  it also needs to emit code that matches
the syntax of the language.

so a general purpose lttng tracepoint parsing tool would need at least a
limited understanding of the syntax and grammar of each language for
reading the source file in and then writing the source file out.  there
could be code in the middle that's common across languages, but probably
not a lot.  perhaps an lttng tracepoint parsing tool could be better
structured as a common framework for language specific tracepoint parsers
to be plugged in to.

but writing a parser that actually understands the grammar of a language is
not easy.  if i was really going to do this, i'd be tempted to see if i
could just take this from gcc (which has front-ends that supports C, C++,
Go, and other languages (i think)).

and then there's the tracepoint definitions.  they could be written using
the barectf() tool that Philippe mentions, but i'm not sure if that would
be satisfactory for most programmers, who would prefer to write tracepoint
definitions in the same language that they are programming in.  they would
also need to support the data types of the language (i'm thinking Python
here as an example, where tracepoints would be expected to support most of
the Python basic data types).


because Go seems to be similar to C i'm strongly tempted to just co-opt the
C pre-processor and existing LTTng tracepoint machinery and modify the
LTTng header files to generate valid Go code for a tracepoint definition.
this does add a LTTng tracepoint tool to the steps required to compile Go,
except that the tracepoint tool is called "cpp" (plus header files).

i don't really know Go yet and i hae not been assigned to get LTTng to work
in Go, so this is all quite preliminary.  but i think the project i'm about
to start on really needs LTTng or LTTng-like tracepoint functionality so
i'm motivated to see if this can work.

i'm going to investigate some more.

--craig


On Fri, Jun 2, 2017 at 10:05 AM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Fri, Jun 2, 2017 at 11:58 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>>
>> ----- On Jun 2, 2017, at 2:27 AM, craig harmer <charmster@gmail.com>
>> wrote:
>>
>> hi all,
>>
>> has anyone looked at porting LTTng to Go
>> <https://en.wikipedia.org/wiki/Go_%28programming_language%29> (AKA Golang
>> <https://golang.org/>)?
>>
>>
>> Not yet ! I'm glad someone is looking into it. :)
>>
>>
>>
>> Go is a language very similar to C, but it has intrinsic support for
>> concurrency and better memory protection (at the expense of including
>> garbage collection).  its from Google and is pretty hot these days for big
>> data and "web scale" distributed systems.  the similarity to C is not
>> surprising since two of the three authors were also involved in the
>> development of UNIX in at AT&T in the 1970's: Rob Pike and Ken Thompson
>> (Robert Griesemer is the third author).
>>
>> Go is able to link with C object files, so implementing support for
>> tracef(3) should not be very difficult.
>>
>> but i want to have full support for user-defined tracepoint() events.
>> that looks to be much trickier since the LTTng tracepoint() functionality
>> relies heavily on (some might say abuses
>>
>> "abuses" is appropriate ;-)
>
>> ) the C pre-processor, and Go does not have an equivalent of the C
>> pre-processor.  however, i don't see an obvious reason why Go source files
>> that contain tracepoints couldn't be run through the C pre-processor --
>> except that Go specific LTTng header files would be required.
>>
>> here is an example of "hello, world" in Go
>> <https://tour.golang.org/welcome/1>.  (note the use of "import" rather
>> then "#include").
>>
>> i've spent more than a few hours looking at the C code generated by the C
>> pre-processor trying to track down exactly why a tracepoint() definition is
>> causing a compiler error, so i think i have an idea of just how hard it
>> would be to development equivalent header files for Go + C pre-processor.
>> it may be the case that the Go "header files", once developed, would be
>> compiler specific, i.e only work with gccgo
>> <https://golang.org/doc/install/gccgo> (the gcc front-end for Go).
>>
>> anyway, i'm wondering if anybody has attempted this and/or what your
>> thoughts would be.
>>
>> In the case of C/C++ code, using the C preprocessor got the job done
>> without requiring any additional
>> dependency. Given the context you describe, perhaps it would be wise to
>> consider introducing a dedicated
>> "lttng probe description" parser. The idea here would be to parse the
>> tracepoint probe definitions and
>> translate those into native code for various languages (e.g. Golang).
>>
>> This would create a new lttng utility that would be required to to
>> produce the language-specific files from
>> those descriptions. I would allow us to port the "tracepoint" concept to
>> many more languages easily, and
>> not be so much tied to the C preprocessor anymore.
>>
>
>> So perhaps adding this new tool as a dependency that needs to be invoked
>> prior to compilation might
>> not be too much of an issue ? I see it as being slightly similar to the
>> role accomplished by Flex and
>> Bison: they are required to translate from source files to an
>> intermediary language, and then the
>> resulting files can be included into the distribution source packages, so
>> only those who aim at
>> changing the source descriptions need to have the translation tool
>> installed.
>>
>
>> Thoughts ?
>>
>
> Good point and we thought about this before. In fact this is just what
> barectf <http://barectf.org/> does, for example. What I see in the future
> is that a subset of (eventual) CTF 2's metadata language (JSON) could be
> used here (or an equivalent, human-friendly YAML, like barectf) to describe
> LTTng event and stream classes and translate them to what's needed to
> record such events for a given programming language. CTF 2's user
> attributes can be used to insert additional, language-specific properties,
> like parameter types and names, and other options.
>
> Phil
>
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>>
>>
>>
>> --craig
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>

--001a114e254ab61f2e055104f89e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif">hi all,<br><br></div><div class=3D"gmail_default" style=3D=
"font-family:trebuchet ms,sans-serif">the suggestion to write a pre-process=
or for LTTng tracepoints is interesting and may be a good idea.=C2=A0 howev=
er, i&#39;m not sure that it will provide a general purpose solution.<br><b=
r></div><div class=3D"gmail_default" style=3D"font-family:trebuchet ms,sans=
-serif">the problem i for see is that tracepoint invocations, at least, sho=
uld be written in the syntax of the language they&#39;re being used in (a p=
rogrammer would would expect the tracepoint() function call to look like an=
y other function call in the language).<br><br>so the tracepoint parser nee=
ds to understand the function invocation syntax of each language.=C2=A0 it =
also needs to understand at least some of the rest of the syntax of the lan=
guage -- in the case of Go it at least needs to be able recognize &quot;imp=
ort&quot; statements and import those files and it needs to understand when=
 something that looks like a tracepoint() is actually embedded in a comment=
 or string.=C2=A0 it also needs to emit code that matches the syntax of the=
 language.<br><br>so a general purpose lttng tracepoint parsing tool would =
need at least a limited understanding of the syntax and grammar of each lan=
guage for reading the source file in and then writing the source file out.=
=C2=A0 there could be code in the middle that&#39;s common across languages=
, but probably not a lot.=C2=A0 perhaps an lttng tracepoint parsing tool co=
uld be better structured as a common framework for language specific tracep=
oint parsers to be plugged in to.<br><br></div><div class=3D"gmail_default"=
 style=3D"font-family:trebuchet ms,sans-serif">but writing a parser that ac=
tually understands the grammar of a language is not easy.=C2=A0 if i was re=
ally going to do this, i&#39;d be tempted to see if i could just take this =
from gcc (which has front-ends that supports C, C++, Go, and other language=
s (i think)).<br></div><div class=3D"gmail_default" style=3D"font-family:tr=
ebuchet ms,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font=
-family:trebuchet ms,sans-serif">and then there&#39;s the tracepoint defini=
tions.=C2=A0 they could be written using the barectf() tool that Philippe m=
entions, but i&#39;m not sure if that would be satisfactory for most progra=
mmers, who would prefer to write tracepoint definitions in the same languag=
e that they are programming in.=C2=A0 they would also need to support the d=
ata types of the language (i&#39;m thinking Python here as an example, wher=
e tracepoints would be expected to support most of the Python basic data ty=
pes).<br></div><div class=3D"gmail_default" style=3D"font-family:trebuchet =
ms,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:=
trebuchet ms,sans-serif"><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:trebuchet ms,sans-serif">because Go seems to be similar to C i&#3=
9;m strongly tempted to just co-opt the C pre-processor and existing LTTng =
tracepoint machinery and modify the LTTng header files to generate valid Go=
 code for a tracepoint definition.=C2=A0 this does add a LTTng tracepoint t=
ool to the steps required to compile Go, except that the tracepoint tool is=
 called &quot;cpp&quot; (plus header files).<br><br></div><div class=3D"gma=
il_default" style=3D"font-family:trebuchet ms,sans-serif">i don&#39;t reall=
y know Go yet and i hae not been assigned to get LTTng to work in Go, so th=
is is all quite preliminary.=C2=A0 but i think the project i&#39;m about to=
 start on really needs LTTng or LTTng-like tracepoint functionality so i&#3=
9;m motivated to see if this can work.<br><br></div><div class=3D"gmail_def=
ault" style=3D"font-family:trebuchet ms,sans-serif">i&#39;m going to invest=
igate some more.<br></div><div class=3D"gmail_default" style=3D"font-family=
:trebuchet ms,sans-serif"><br></div><div class=3D"gmail_default" style=3D"f=
ont-family:trebuchet ms,sans-serif">--craig<br></div><div class=3D"gmail_de=
fault" style=3D"font-family:trebuchet ms,sans-serif"><br></div></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jun 2, 2017 at =
10:05 AM, Philippe Proulx <span dir=3D"ltr">&lt;<a href=3D"mailto:eeppelite=
loop@gmail.com" target=3D"_blank">eeppeliteloop@gmail.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail=
_extra"><span class=3D""><div><div class=3D"m_790898205284245872gmail_signa=
ture">On Fri, Jun 2, 2017 at 11:58 AM, Mathieu Desnoyers <span dir=3D"ltr">=
&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mat=
hieu.desnoyers@efficios.<wbr>com</a>&gt;</span> wrote:<br></div></div></spa=
n><div class=3D"gmail_quote"><span class=3D""><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-se=
rif;font-size:12pt;color:rgb(0,0,0)"><span class=3D"m_790898205284245872gma=
il-"><div><br></div><span id=3D"m_790898205284245872gmail-m_-50401757813095=
88822zwchr">----- On Jun 2, 2017, at 2:27 AM, craig harmer &lt;<a href=3D"m=
ailto:charmster@gmail.com" target=3D"_blank">charmster@gmail.com</a>&gt; wr=
ote:<br></span></span><div><span class=3D"m_790898205284245872gmail-"><bloc=
kquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;paddin=
g-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decor=
ation:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr"><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">hi =
all,<br><br></div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-s=
erif">has anyone looked at porting LTTng to <a href=3D"https://en.wikipedia=
.org/wiki/Go_%28programming_language%29" target=3D"_blank">Go</a> (AKA <a h=
ref=3D"https://golang.org/" target=3D"_blank">Golang</a>)?</div></div></blo=
ckquote><div><br></div></span><div>Not yet ! I&#39;m glad someone is lookin=
g into it. :)<br></div><span class=3D"m_790898205284245872gmail-"><div><br>=
</div><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left=
:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal=
;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt=
"><div dir=3D"ltr"><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-=
serif"><br><br></div><div style=3D"font-family:&quot;trebuchet ms&quot;,san=
s-serif">Go is a language very similar to C, but it has intrinsic support f=
or concurrency and better memory protection (at the expense of including ga=
rbage collection).=C2=A0 its from Google and is pretty hot these days for b=
ig data and &quot;web scale&quot; distributed systems.=C2=A0 the similarity=
 to C is not surprising since two of the three authors were also involved i=
n the development of UNIX in at AT&amp;T in the 1970&#39;s: Rob Pike and Ke=
n Thompson (Robert Griesemer is the third author).<br><br>Go is able to lin=
k with C object files, so implementing support for tracef(3) should not be =
very difficult. <br></div><div style=3D"font-family:&quot;trebuchet ms&quot=
;,sans-serif"><br>but i want to have full support for user-defined tracepoi=
nt() events.=C2=A0 that looks to be much trickier since the LTTng tracepoin=
t() functionality relies heavily on (some might say abuses</div></div></blo=
ckquote></span></div></div></div></blockquote></span><div>&quot;abuses&quot=
; is appropriate ;-)=C2=A0</div><span class=3D""><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans=
-serif;font-size:12pt;color:rgb(0,0,0)"><div><span class=3D"m_7908982052842=
45872gmail-"><blockquote style=3D"border-left:2px solid rgb(16,16,255);marg=
in-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt"><div dir=3D"ltr"><div style=3D"font-family:&quot;trebuchet ms&quot=
;,sans-serif">) the C pre-processor, and Go does not have an equivalent of =
the C pre-processor.=C2=A0 however, i don&#39;t see an obvious reason why G=
o source files that contain tracepoints couldn&#39;t be run through the C p=
re-processor -- except that Go specific LTTng header files would be require=
d.<br><br><a href=3D"https://tour.golang.org/welcome/1" target=3D"_blank">h=
ere is an example of &quot;hello, world&quot; in Go</a>.=C2=A0 (note the us=
e of &quot;import&quot; rather then &quot;#include&quot;).<br><br></div><di=
v style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">i&#39;ve spent =
more than a few hours looking at the C code generated by the C pre-processo=
r trying to track down exactly why a tracepoint() definition is causing a c=
ompiler error, so i think i have an idea of just how hard it would be to de=
velopment equivalent header files for Go + C pre-processor.=C2=A0 it may be=
 the case that the Go &quot;header files&quot;, once developed, would be co=
mpiler specific, i.e only work with <a href=3D"https://golang.org/doc/insta=
ll/gccgo" target=3D"_blank">gccgo</a> (the gcc front-end for Go).<br></div>=
<div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif"><br></div><d=
iv style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">anyway, i&#39;=
m wondering if anybody has attempted this and/or what your thoughts would b=
e.</div></div></blockquote></span><div>In the case of C/C++ code, using the=
 C preprocessor got the job done without requiring any additional<br></div>=
<div>dependency. Given the context you describe, perhaps it would be wise t=
o consider introducing a dedicated</div><div>&quot;lttng probe description&=
quot; parser. The idea here would be to parse the tracepoint probe definiti=
ons and</div><div>translate those into native code for various languages (e=
.g. Golang).<br></div><div><br></div><div>This would create a new lttng uti=
lity that would be required to to produce the language-specific files from<=
/div><div>those descriptions. I would allow us to port the &quot;tracepoint=
&quot; concept to many more languages easily, and</div><div>not be so much =
tied to the C preprocessor anymore.<span style=3D"font-family:arial,sans-se=
rif;font-size:small;color:rgb(34,34,34)">=C2=A0</span></div></div></div></d=
iv></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div=
 style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0=
,0,0)"><div><div></div><div><br></div><div>So perhaps adding this new tool =
as a dependency that needs to be invoked prior to compilation might</div><d=
iv>not be too much of an issue ? I see it as being slightly similar to the =
role accomplished by Flex and<br></div><div>Bison: they are required to tra=
nslate from source files to an intermediary language, and then the<br></div=
><div>resulting files can be included into the distribution source packages=
, so only those who aim at<br></div><div>changing the source descriptions n=
eed to have the translation tool installed.<br></div></div></div></div></bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div style=
=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"=
><div><div><br></div><div>Thoughts ?<br></div></div></div></div></blockquot=
e><div><br></div></span><div>Good point and we thought about this before. I=
n fact this is just what barectf &lt;<a href=3D"http://barectf.org/" target=
=3D"_blank">http://barectf.org/</a>&gt;=C2=A0does, for example. What I see =
in the future is that a subset of (eventual) CTF 2&#39;s metadata language =
(JSON) could be used here (or an equivalent, human-friendly YAML, like bare=
ctf) to describe LTTng event and stream classes and translate them to what&=
#39;s needed to record such events for a given programming language. CTF 2&=
#39;s user attributes can be used to insert additional, language-specific p=
roperties, like parameter types and names, and other options.</div><div><br=
></div><div>Phil=C2=A0</div><span class=3D""><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-ser=
if;font-size:12pt;color:rgb(0,0,0)"><div><div></div><div><br></div><div>Tha=
nks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br>=
</div><div><br></div><blockquote style=3D"border-left:2px solid rgb(16,16,2=
55);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;fo=
nt-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif=
;font-size:12pt"><div dir=3D"ltr"><div style=3D"font-family:&quot;trebuchet=
 ms&quot;,sans-serif"><br></div><div style=3D"font-family:&quot;trebuchet m=
s&quot;,sans-serif"><br></div><div style=3D"font-family:&quot;trebuchet ms&=
quot;,sans-serif">--craig<br></div></div><br>______________________________=
<wbr>_________________<br>lttng-dev mailing list<br><a href=3D"mailto:lttng=
-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a=
 href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=
=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mailman/listinfo/lttng-dev=
</a><span class=3D"m_790898205284245872gmail-HOEnZb"><font color=3D"#888888=
"><br></font></span></blockquote></div><span class=3D"m_790898205284245872g=
mail-HOEnZb"><font color=3D"#888888"><br><div>-- <br></div><div>Mathieu Des=
noyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_b=
lank">http://www.efficios.com</a></div></font></span></div></div><br>______=
________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></span></div><br></div></div>
</blockquote></div><br></div>

--001a114e254ab61f2e055104f89e--

--===============4633950577094324889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4633950577094324889==--
