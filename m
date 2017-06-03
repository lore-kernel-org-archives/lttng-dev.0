From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: porting LTTng to Go(lang)?
Date: Sat, 3 Jun 2017 15:45:39 -0400
Message-ID: <CAB4xu_3cFxuaGwYQxpsA0oFP7g0gqbBt_9g0LARtt2tsNJk53Q__44787.7508974217$1496519549$gmane$org@mail.gmail.com>
References: <CADjtVtYQ2M_j=CnPrjP81ECZKa1vzfE-xJ5QnEkDhaT+uk=9cg@mail.gmail.com>
 <1949609462.4236.1496419081125.JavaMail.zimbra@efficios.com>
 <CAB4xu_00+eFuXmod=GsS+rHs4Do1WwS5DYRsX4u8PdRGr6zpvg@mail.gmail.com>
 <CADjtVta3FFsAvk-rOaChb0rQs9_UzBUZ3K7ZX++aoKhqiRXWCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7578857848334175177=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x22b.google.com (mail-qt0-x22b.google.com
 [IPv6:2607:f8b0:400d:c0d::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 3wgBSR6K6rz12Pb
 for <lttng-dev@lists.lttng.org>; Sat,  3 Jun 2017 19:47:35 +0000 (UTC)
Received: by mail-qt0-x22b.google.com with SMTP id f55so79186222qta.3
 for <lttng-dev@lists.lttng.org>; Sat, 03 Jun 2017 12:46:10 -0700 (PDT)
In-Reply-To: <CADjtVta3FFsAvk-rOaChb0rQs9_UzBUZ3K7ZX++aoKhqiRXWCA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: craig harmer <charmster@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7578857848334175177==
Content-Type: multipart/alternative; boundary="001a11406f228091730551138574"

--001a11406f228091730551138574
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 2, 2017 at 10:24 PM, craig harmer <charmster@gmail.com> wrote:

> hi all,
>
> the suggestion to write a pre-processor for LTTng tracepoints is
> interesting and may be a good idea.  however, i'm not sure that it will
> provide a general purpose solution.
>
> the problem i for see is that tracepoint invocations, at least, should be
> written in the syntax of the language they're being used in (a programmer
> would would expect the tracepoint() function call to look like any other
> function call in the language).
>
> so the tracepoint parser needs to understand the function invocation
> syntax of each language.  it also needs to understand at least some of the
> rest of the syntax of the language -- in the case of Go it at least needs
> to be able recognize "import" statements and import those files and it
> needs to understand when something that looks like a tracepoint() is
> actually embedded in a comment or string.  it also needs to emit code that
> matches the syntax of the language.
>
> so a general purpose lttng tracepoint parsing tool would need at least a
> limited understanding of the syntax and grammar of each language for
> reading the source file in and then writing the source file out.  there
> could be code in the middle that's common across languages, but probably
> not a lot.  perhaps an lttng tracepoint parsing tool could be better
> structured as a common framework for language specific tracepoint parsers
> to be plugged in to.
>
> but writing a parser that actually understands the grammar of a language
> is not easy.  if i was really going to do this, i'd be tempted to see if i
> could just take this from gcc (which has front-ends that supports C, C++,
> Go, and other languages (i think)).
>
> and then there's the tracepoint definitions.  they could be written using
> the barectf() tool that Philippe mentions, but i'm not sure if that would
> be satisfactory for most programmers, who would prefer to write tracepoint
> definitions in the same language that they are programming in.  they would
> also need to support the data types of the language (i'm thinking Python
> here as an example, where tracepoints would be expected to support most of
> the Python basic data types).
>

There's a little misunderstanding here.

The idea is to have a universal tracepoint definition language (and what I
suggested is that a subset of CTF 2, of which the syntax is JSON (or YAML
which translates to JSON directly), could be used for this) which
translates to functions, classes, macros, etc. in selected programming
languages. Depending on the destination language, we can generate
serialization functions directly or wrappers which use LTTng-UST behind the
scenes. So in your case, this tool would generate Go source files which
would contain public functions which correspond to tracepoints. We never
considered parsing an existing programming language to infer tracepoints.

Of course this requires the developer to define tracepoints in this
universal language. That's an additional developing step needed to allow
the developer to use tracepoints in his/her favorite language. But there
are other advantages, like generating tracepoints in two different
languages from the same tracepoint definitions. Like Mathieu wrote, it's
the same spirit as Flex and Bison. With Bison, you don't use the C
preprocessor to write your grammar rules: the tool reads a Bison input file
and generates a parser source file. Just like barectf reads a YAML
configuration file which defines stream and event classes and generates
tracer source files.

Phil

>
>
> because Go seems to be similar to C i'm strongly tempted to just co-opt
> the C pre-processor and existing LTTng tracepoint machinery and modify the
> LTTng header files to generate valid Go code for a tracepoint definition.
> this does add a LTTng tracepoint tool to the steps required to compile Go,
> except that the tracepoint tool is called "cpp" (plus header files).
>
> i don't really know Go yet and i hae not been assigned to get LTTng to
> work in Go, so this is all quite preliminary.  but i think the project i'm
> about to start on really needs LTTng or LTTng-like tracepoint functionality
> so i'm motivated to see if this can work.
>

> i'm going to investigate some more.
>
> --craig
>
>
> On Fri, Jun 2, 2017 at 10:05 AM, Philippe Proulx <eeppeliteloop@gmail.com>
> wrote:
>
>> On Fri, Jun 2, 2017 at 11:58 AM, Mathieu Desnoyers <
>> mathieu.desnoyers@efficios.com> wrote:
>>
>>>
>>> ----- On Jun 2, 2017, at 2:27 AM, craig harmer <charmster@gmail.com>
>>> wrote:
>>>
>>> hi all,
>>>
>>> has anyone looked at porting LTTng to Go
>>> <https://en.wikipedia.org/wiki/Go_%28programming_language%29> (AKA
>>> Golang <https://golang.org/>)?
>>>
>>>
>>> Not yet ! I'm glad someone is looking into it. :)
>>>
>>>
>>>
>>> Go is a language very similar to C, but it has intrinsic support for
>>> concurrency and better memory protection (at the expense of including
>>> garbage collection).  its from Google and is pretty hot these days for big
>>> data and "web scale" distributed systems.  the similarity to C is not
>>> surprising since two of the three authors were also involved in the
>>> development of UNIX in at AT&T in the 1970's: Rob Pike and Ken Thompson
>>> (Robert Griesemer is the third author).
>>>
>>> Go is able to link with C object files, so implementing support for
>>> tracef(3) should not be very difficult.
>>>
>>> but i want to have full support for user-defined tracepoint() events.
>>> that looks to be much trickier since the LTTng tracepoint() functionality
>>> relies heavily on (some might say abuses
>>>
>>> "abuses" is appropriate ;-)
>>
>>> ) the C pre-processor, and Go does not have an equivalent of the C
>>> pre-processor.  however, i don't see an obvious reason why Go source files
>>> that contain tracepoints couldn't be run through the C pre-processor --
>>> except that Go specific LTTng header files would be required.
>>>
>>> here is an example of "hello, world" in Go
>>> <https://tour.golang.org/welcome/1>.  (note the use of "import" rather
>>> then "#include").
>>>
>>> i've spent more than a few hours looking at the C code generated by the
>>> C pre-processor trying to track down exactly why a tracepoint() definition
>>> is causing a compiler error, so i think i have an idea of just how hard it
>>> would be to development equivalent header files for Go + C pre-processor.
>>> it may be the case that the Go "header files", once developed, would be
>>> compiler specific, i.e only work with gccgo
>>> <https://golang.org/doc/install/gccgo> (the gcc front-end for Go).
>>>
>>> anyway, i'm wondering if anybody has attempted this and/or what your
>>> thoughts would be.
>>>
>>> In the case of C/C++ code, using the C preprocessor got the job done
>>> without requiring any additional
>>> dependency. Given the context you describe, perhaps it would be wise to
>>> consider introducing a dedicated
>>> "lttng probe description" parser. The idea here would be to parse the
>>> tracepoint probe definitions and
>>> translate those into native code for various languages (e.g. Golang).
>>>
>>> This would create a new lttng utility that would be required to to
>>> produce the language-specific files from
>>> those descriptions. I would allow us to port the "tracepoint" concept to
>>> many more languages easily, and
>>> not be so much tied to the C preprocessor anymore.
>>>
>>
>>> So perhaps adding this new tool as a dependency that needs to be invoked
>>> prior to compilation might
>>> not be too much of an issue ? I see it as being slightly similar to the
>>> role accomplished by Flex and
>>> Bison: they are required to translate from source files to an
>>> intermediary language, and then the
>>> resulting files can be included into the distribution source packages,
>>> so only those who aim at
>>> changing the source descriptions need to have the translation tool
>>> installed.
>>>
>>
>>> Thoughts ?
>>>
>>
>> Good point and we thought about this before. In fact this is just what
>> barectf <http://barectf.org/> does, for example. What I see in the
>> future is that a subset of (eventual) CTF 2's metadata language (JSON)
>> could be used here (or an equivalent, human-friendly YAML, like barectf) to
>> describe LTTng event and stream classes and translate them to what's needed
>> to record such events for a given programming language. CTF 2's user
>> attributes can be used to insert additional, language-specific properties,
>> like parameter types and names, and other options.
>>
>> Phil
>>
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>
>>>
>>>
>>>
>>> --craig
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>

--001a11406f228091730551138574
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, Jun 2, 2017 at 10:24 PM, craig harmer <span dir=3D"ltr">&lt;<a href=3D"=
mailto:charmster@gmail.com" target=3D"_blank">charmster@gmail.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">hi =
all,<br><br></div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-s=
erif">the suggestion to write a pre-processor for LTTng tracepoints is inte=
resting and may be a good idea.=C2=A0 however, i&#39;m not sure that it wil=
l provide a general purpose solution.<br><br></div><div style=3D"font-famil=
y:&quot;trebuchet ms&quot;,sans-serif">the problem i for see is that tracep=
oint invocations, at least, should be written in the syntax of the language=
 they&#39;re being used in (a programmer would would expect the tracepoint(=
) function call to look like any other function call in the language).<br><=
br>so the tracepoint parser needs to understand the function invocation syn=
tax of each language.=C2=A0 it also needs to understand at least some of th=
e rest of the syntax of the language -- in the case of Go it at least needs=
 to be able recognize &quot;import&quot; statements and import those files =
and it needs to understand when something that looks like a tracepoint() is=
 actually embedded in a comment or string.=C2=A0 it also needs to emit code=
 that matches the syntax of the language.<br><br>so a general purpose lttng=
 tracepoint parsing tool would need at least a limited understanding of the=
 syntax and grammar of each language for reading the source file in and the=
n writing the source file out.=C2=A0 there could be code in the middle that=
&#39;s common across languages, but probably not a lot.=C2=A0 perhaps an lt=
tng tracepoint parsing tool could be better structured as a common framewor=
k for language specific tracepoint parsers to be plugged in to.<br><br></di=
v><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">but writin=
g a parser that actually understands the grammar of a language is not easy.=
=C2=A0 if i was really going to do this, i&#39;d be tempted to see if i cou=
ld just take this from gcc (which has front-ends that supports C, C++, Go, =
and other languages (i think)).<br></div><div style=3D"font-family:&quot;tr=
ebuchet ms&quot;,sans-serif"><br></div><div style=3D"font-family:&quot;treb=
uchet ms&quot;,sans-serif">and then there&#39;s the tracepoint definitions.=
=C2=A0 they could be written using the barectf() tool that Philippe mention=
s, but i&#39;m not sure if that would be satisfactory for most programmers,=
 who would prefer to write tracepoint definitions in the same language that=
 they are programming in.=C2=A0 they would also need to support the data ty=
pes of the language (i&#39;m thinking Python here as an example, where trac=
epoints would be expected to support most of the Python basic data types).<=
br></div></div></blockquote><div><br></div><div>There&#39;s a little misund=
erstanding here.</div><div><br></div><div>The idea is to have a universal t=
racepoint definition language (and what I suggested is that a subset of CTF=
 2, of which the syntax is JSON (or YAML which translates to JSON directly)=
, could be used for this) which translates to functions, classes, macros, e=
tc. in selected programming languages. Depending on the destination languag=
e, we can generate serialization functions directly or wrappers which use L=
TTng-UST behind the scenes. So in your case, this tool would generate Go so=
urce files which would contain public functions which correspond to tracepo=
ints. We never considered parsing an existing programming language to infer=
 tracepoints.</div><div><br></div><div>Of course this requires the develope=
r to define tracepoints in this universal language. That&#39;s an additiona=
l developing step needed to allow the developer to use tracepoints in his/h=
er favorite language. But there are other advantages, like generating trace=
points in two different languages from the same tracepoint definitions. Lik=
e Mathieu wrote, it&#39;s the same spirit as Flex and Bison. With Bison, yo=
u don&#39;t use the C preprocessor to write your grammar rules: the tool re=
ads a Bison input file and generates a parser source file. Just like barect=
f reads a YAML configuration file which defines stream and event classes an=
d generates tracer source files.</div><div><br></div><div>Phil</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div style=3D"f=
ont-family:&quot;trebuchet ms&quot;,sans-serif"></div><div style=3D"font-fa=
mily:&quot;trebuchet ms&quot;,sans-serif"><br></div><div style=3D"font-fami=
ly:&quot;trebuchet ms&quot;,sans-serif"><br></div><div style=3D"font-family=
:&quot;trebuchet ms&quot;,sans-serif">because Go seems to be similar to C i=
&#39;m strongly tempted to just co-opt the C pre-processor and existing LTT=
ng tracepoint machinery and modify the LTTng header files to generate valid=
 Go code for a tracepoint definition.=C2=A0 this does add a LTTng tracepoin=
t tool to the steps required to compile Go, except that the tracepoint tool=
 is called &quot;cpp&quot; (plus header files).<br><br></div><div style=3D"=
font-family:&quot;trebuchet ms&quot;,sans-serif">i don&#39;t really know Go=
 yet and i hae not been assigned to get LTTng to work in Go, so this is all=
 quite preliminary.=C2=A0 but i think the project i&#39;m about to start on=
 really needs LTTng or LTTng-like tracepoint functionality so i&#39;m motiv=
ated to see if this can work.<span style=3D"font-family:arial,sans-serif">=
=C2=A0</span></div></div></blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div style=3D"font-family:&quot;trebuchet ms&=
quot;,sans-serif"><br></div><div style=3D"font-family:&quot;trebuchet ms&qu=
ot;,sans-serif">i&#39;m going to investigate some more.<span class=3D"gmail=
-m_-6643529984790646395HOEnZb"><font color=3D"#888888"><br></font></span></=
div><span class=3D"gmail-m_-6643529984790646395HOEnZb"><font color=3D"#8888=
88"><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif"><br></di=
v><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">--craig<br=
></div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif"><br><=
/div></font></span></div><div class=3D"gmail-m_-6643529984790646395HOEnZb">=
<div class=3D"gmail-m_-6643529984790646395h5"><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Fri, Jun 2, 2017 at 10:05 AM, Philippe Prou=
lx <span dir=3D"ltr">&lt;<a href=3D"mailto:eeppeliteloop@gmail.com" target=
=3D"_blank">eeppeliteloop@gmail.com</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_ex=
tra"><span><div><div class=3D"gmail-m_-6643529984790646395m_509151755971753=
8205m_790898205284245872gmail_signature">On Fri, Jun 2, 2017 at 11:58 AM, M=
athieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@=
efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.co<wbr>m</a>&gt;=
</span> wrote:<br></div></div></span><div class=3D"gmail_quote"><span><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div><div style=3D"font-family=
:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><span class=3D=
"gmail-m_-6643529984790646395m_5091517559717538205m_790898205284245872gmail=
-"><div><br></div><span id=3D"gmail-m_-6643529984790646395m_509151755971753=
8205m_790898205284245872gmail-m_-5040175781309588822zwchr">----- On Jun 2, =
2017, at 2:27 AM, craig harmer &lt;<a href=3D"mailto:charmster@gmail.com" t=
arget=3D"_blank">charmster@gmail.com</a>&gt; wrote:<br></span></span><div><=
span class=3D"gmail-m_-6643529984790646395m_5091517559717538205m_7908982052=
84245872gmail-"><blockquote style=3D"border-left:2px solid rgb(16,16,255);m=
argin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt"><div dir=3D"ltr"><div style=3D"font-family:&quot;trebuchet ms&q=
uot;,sans-serif">hi all,<br><br></div><div style=3D"font-family:&quot;trebu=
chet ms&quot;,sans-serif">has anyone looked at porting LTTng to <a href=3D"=
https://en.wikipedia.org/wiki/Go_%28programming_language%29" target=3D"_bla=
nk">Go</a> (AKA <a href=3D"https://golang.org/" target=3D"_blank">Golang</a=
>)?</div></div></blockquote><div><br></div></span><div>Not yet ! I&#39;m gl=
ad someone is looking into it. :)<br></div><span class=3D"gmail-m_-66435299=
84790646395m_5091517559717538205m_790898205284245872gmail-"><div><br></div>=
<blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;p=
adding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div=
 dir=3D"ltr"><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif"=
><br><br></div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-seri=
f">Go is a language very similar to C, but it has intrinsic support for con=
currency and better memory protection (at the expense of including garbage =
collection).=C2=A0 its from Google and is pretty hot these days for big dat=
a and &quot;web scale&quot; distributed systems.=C2=A0 the similarity to C =
is not surprising since two of the three authors were also involved in the =
development of UNIX in at AT&amp;T in the 1970&#39;s: Rob Pike and Ken Thom=
pson (Robert Griesemer is the third author).<br><br>Go is able to link with=
 C object files, so implementing support for tracef(3) should not be very d=
ifficult. <br></div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans=
-serif"><br>but i want to have full support for user-defined tracepoint() e=
vents.=C2=A0 that looks to be much trickier since the LTTng tracepoint() fu=
nctionality relies heavily on (some might say abuses</div></div></blockquot=
e></span></div></div></div></blockquote></span><div>&quot;abuses&quot; is a=
ppropriate ;-)=C2=A0</div><span><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:=
12pt;color:rgb(0,0,0)"><div><span class=3D"gmail-m_-6643529984790646395m_50=
91517559717538205m_790898205284245872gmail-"><blockquote style=3D"border-le=
ft:2px solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,=
0);font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div style=3D"fon=
t-family:&quot;trebuchet ms&quot;,sans-serif">) the C pre-processor, and Go=
 does not have an equivalent of the C pre-processor.=C2=A0 however, i don&#=
39;t see an obvious reason why Go source files that contain tracepoints cou=
ldn&#39;t be run through the C pre-processor -- except that Go specific LTT=
ng header files would be required.<br><br><a href=3D"https://tour.golang.or=
g/welcome/1" target=3D"_blank">here is an example of &quot;hello, world&quo=
t; in Go</a>.=C2=A0 (note the use of &quot;import&quot; rather then &quot;#=
include&quot;).<br><br></div><div style=3D"font-family:&quot;trebuchet ms&q=
uot;,sans-serif">i&#39;ve spent more than a few hours looking at the C code=
 generated by the C pre-processor trying to track down exactly why a tracep=
oint() definition is causing a compiler error, so i think i have an idea of=
 just how hard it would be to development equivalent header files for Go + =
C pre-processor.=C2=A0 it may be the case that the Go &quot;header files&qu=
ot;, once developed, would be compiler specific, i.e only work with <a href=
=3D"https://golang.org/doc/install/gccgo" target=3D"_blank">gccgo</a> (the =
gcc front-end for Go).<br></div><div style=3D"font-family:&quot;trebuchet m=
s&quot;,sans-serif"><br></div><div style=3D"font-family:&quot;trebuchet ms&=
quot;,sans-serif">anyway, i&#39;m wondering if anybody has attempted this a=
nd/or what your thoughts would be.</div></div></blockquote></span><div>In t=
he case of C/C++ code, using the C preprocessor got the job done without re=
quiring any additional<br></div><div>dependency. Given the context you desc=
ribe, perhaps it would be wise to consider introducing a dedicated</div><di=
v>&quot;lttng probe description&quot; parser. The idea here would be to par=
se the tracepoint probe definitions and</div><div>translate those into nati=
ve code for various languages (e.g. Golang).<br></div><div><br></div><div>T=
his would create a new lttng utility that would be required to to produce t=
he language-specific files from</div><div>those descriptions. I would allow=
 us to port the &quot;tracepoint&quot; concept to many more languages easil=
y, and</div><div>not be so much tied to the C preprocessor anymore.<span st=
yle=3D"font-family:arial,sans-serif;font-size:small;color:rgb(34,34,34)">=
=C2=A0</span></div></div></div></div></blockquote><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,san=
s-serif;font-size:12pt;color:rgb(0,0,0)"><div><div></div><div><br></div><di=
v>So perhaps adding this new tool as a dependency that needs to be invoked =
prior to compilation might</div><div>not be too much of an issue ? I see it=
 as being slightly similar to the role accomplished by Flex and<br></div><d=
iv>Bison: they are required to translate from source files to an intermedia=
ry language, and then the<br></div><div>resulting files can be included int=
o the distribution source packages, so only those who aim at<br></div><div>=
changing the source descriptions need to have the translation tool installe=
d.<br></div></div></div></div></blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif=
;font-size:12pt;color:rgb(0,0,0)"><div><div><br></div><div>Thoughts ?<br></=
div></div></div></div></blockquote><div><br></div></span><div>Good point an=
d we thought about this before. In fact this is just what barectf &lt;<a hr=
ef=3D"http://barectf.org/" target=3D"_blank">http://barectf.org/</a>&gt;=C2=
=A0does, for example. What I see in the future is that a subset of (eventua=
l) CTF 2&#39;s metadata language (JSON) could be used here (or an equivalen=
t, human-friendly YAML, like barectf) to describe LTTng event and stream cl=
asses and translate them to what&#39;s needed to record such events for a g=
iven programming language. CTF 2&#39;s user attributes can be used to inser=
t additional, language-specific properties, like parameter types and names,=
 and other options.</div><div><br></div><div>Phil=C2=A0</div><span><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div><div style=3D"font-family:ar=
ial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div><div></div><=
div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><d=
iv><br></div><div><br></div><div><br></div><blockquote style=3D"border-left=
:2px solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0)=
;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helv=
etica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div style=3D"font-=
family:&quot;trebuchet ms&quot;,sans-serif"><br></div><div style=3D"font-fa=
mily:&quot;trebuchet ms&quot;,sans-serif"><br></div><div style=3D"font-fami=
ly:&quot;trebuchet ms&quot;,sans-serif">--craig<br></div></div><br>________=
______________________<wbr>_________________<br>lttng-dev mailing list<br><=
a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lis=
ts.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><span class=3D"gmail-m_-6643529984790646395m_5091=
517559717538205m_790898205284245872gmail-HOEnZb"><font color=3D"#888888"><b=
r></font></span></blockquote></div><span class=3D"gmail-m_-6643529984790646=
395m_5091517559717538205m_790898205284245872gmail-HOEnZb"><font color=3D"#8=
88888"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a =
href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com<=
/a></div></font></span></div></div><br>______________________________<wbr>_=
________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></span></div><br></div></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div></div>

--001a11406f228091730551138574--

--===============7578857848334175177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7578857848334175177==--
