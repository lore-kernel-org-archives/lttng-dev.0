From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: porting LTTng to Go(lang)?
Date: Sun, 4 Jun 2017 16:05:19 +0000 (UTC)
Message-ID: <1075758731.5111.1496592319786.JavaMail.zimbra__44116.0145601772$1496592397$gmane$org@efficios.com>
References: <CADjtVtYQ2M_j=CnPrjP81ECZKa1vzfE-xJ5QnEkDhaT+uk=9cg@mail.gmail.com>
 <1949609462.4236.1496419081125.JavaMail.zimbra@efficios.com>
 <CAB4xu_00+eFuXmod=GsS+rHs4Do1WwS5DYRsX4u8PdRGr6zpvg@mail.gmail.com>
 <CADjtVta3FFsAvk-rOaChb0rQs9_UzBUZ3K7ZX++aoKhqiRXWCA@mail.gmail.com>
 <CAB4xu_3cFxuaGwYQxpsA0oFP7g0gqbBt_9g0LARtt2tsNJk53Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3772308111029641784=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wgjTk5XWvz11f7
 for <lttng-dev@lists.lttng.org>; Sun,  4 Jun 2017 16:05:30 +0000 (UTC)
In-Reply-To: <CAB4xu_3cFxuaGwYQxpsA0oFP7g0gqbBt_9g0LARtt2tsNJk53Q@mail.gmail.com>
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
Cc: craig harmer <charmster@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3772308111029641784==
Content-Type: multipart/alternative;
	boundary="=_be5a396f-d768-420a-a170-4936d5c70777"

--=_be5a396f-d768-420a-a170-4936d5c70777
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jun 3, 2017, at 3:45 PM, Philippe Proulx <eeppeliteloop@gmail.com> wrote: 

> On Fri, Jun 2, 2017 at 10:24 PM, craig harmer < [ mailto:charmster@gmail.com |
> charmster@gmail.com ] > wrote:

>> hi all,

>> the suggestion to write a pre-processor for LTTng tracepoints is interesting and
>> may be a good idea. however, i'm not sure that it will provide a general
>> purpose solution.

>> the problem i for see is that tracepoint invocations, at least, should be
>> written in the syntax of the language they're being used in (a programmer would
>> would expect the tracepoint() function call to look like any other function
>> call in the language).

>> so the tracepoint parser needs to understand the function invocation syntax of
>> each language. it also needs to understand at least some of the rest of the
>> syntax of the language -- in the case of Go it at least needs to be able
>> recognize "import" statements and import those files and it needs to understand
>> when something that looks like a tracepoint() is actually embedded in a comment
>> or string. it also needs to emit code that matches the syntax of the language.

>> so a general purpose lttng tracepoint parsing tool would need at least a limited
>> understanding of the syntax and grammar of each language for reading the source
>> file in and then writing the source file out. there could be code in the middle
>> that's common across languages, but probably not a lot. perhaps an lttng
>> tracepoint parsing tool could be better structured as a common framework for
>> language specific tracepoint parsers to be plugged in to.

>> but writing a parser that actually understands the grammar of a language is not
>> easy. if i was really going to do this, i'd be tempted to see if i could just
>> take this from gcc (which has front-ends that supports C, C++, Go, and other
>> languages (i think)).

>> and then there's the tracepoint definitions. they could be written using the
>> barectf() tool that Philippe mentions, but i'm not sure if that would be
>> satisfactory for most programmers, who would prefer to write tracepoint
>> definitions in the same language that they are programming in. they would also
>> need to support the data types of the language (i'm thinking Python here as an
>> example, where tracepoints would be expected to support most of the Python
>> basic data types).

> There's a little misunderstanding here.

> The idea is to have a universal tracepoint definition language (and what I
> suggested is that a subset of CTF 2, of which the syntax is JSON (or YAML which
> translates to JSON directly), could be used for this) which translates to
> functions, classes, macros, etc. in selected programming languages. Depending
> on the destination language, we can generate serialization functions directly
> or wrappers which use LTTng-UST behind the scenes. So in your case, this tool
> would generate Go source files which would contain public functions which
> correspond to tracepoints. We never considered parsing an existing programming
> language to infer tracepoints.

> Of course this requires the developer to define tracepoints in this universal
> language. That's an additional developing step needed to allow the developer to
> use tracepoints in his/her favorite language. But there are other advantages,
> like generating tracepoints in two different languages from the same tracepoint
> definitions. Like Mathieu wrote, it's the same spirit as Flex and Bison. With
> Bison, you don't use the C preprocessor to write your grammar rules: the tool
> reads a Bison input file and generates a parser source file. Just like barectf
> reads a YAML configuration file which defines stream and event classes and
> generates tracer source files.

The problem is that this is often not enough, and we sometimes need to have 
pre/post code run before/after the serialization to prepare the arguments. 
This happens for instance in lttng-modules with the LTTNG_TRACEPOINT_EVENT_CODE() 
macro. 

Ideally we should find a way to glue together this high-level description 
and language-native helper code. 

Thoughts ? 

Thanks, 

Mathieu 

> Phil

>> because Go seems to be similar to C i'm strongly tempted to just co-opt the C
>> pre-processor and existing LTTng tracepoint machinery and modify the LTTng
>> header files to generate valid Go code for a tracepoint definition. this does
>> add a LTTng tracepoint tool to the steps required to compile Go, except that
>> the tracepoint tool is called "cpp" (plus header files).

>> i don't really know Go yet and i hae not been assigned to get LTTng to work in
>> Go, so this is all quite preliminary. but i think the project i'm about to
>> start on really needs LTTng or LTTng-like tracepoint functionality so i'm
>> motivated to see if this can work.

>> i'm going to investigate some more.

>> --craig

>> On Fri, Jun 2, 2017 at 10:05 AM, Philippe Proulx < [
>> mailto:eeppeliteloop@gmail.com | eeppeliteloop@gmail.com ] > wrote:

>>> On Fri, Jun 2, 2017 at 11:58 AM, Mathieu Desnoyers < [
>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>> wrote:

>>>> ----- On Jun 2, 2017, at 2:27 AM, craig harmer < [ mailto:charmster@gmail.com |
>>>> charmster@gmail.com ] > wrote:

>>>>> hi all,

>>>>> has anyone looked at porting LTTng to [
>>>>> https://en.wikipedia.org/wiki/Go_%28programming_language%29 | Go ] (AKA [
>>>>> https://golang.org/ | Golang ] )?

>>>> Not yet ! I'm glad someone is looking into it. :)

>>>>> Go is a language very similar to C, but it has intrinsic support for concurrency
>>>>> and better memory protection (at the expense of including garbage collection).
>>>>> its from Google and is pretty hot these days for big data and "web scale"
>>>>> distributed systems. the similarity to C is not surprising since two of the
>>>>> three authors were also involved in the development of UNIX in at AT&T in the
>>>>> 1970's: Rob Pike and Ken Thompson (Robert Griesemer is the third author).

>>>>> Go is able to link with C object files, so implementing support for tracef(3)
>>>>> should not be very difficult.

>>>>> but i want to have full support for user-defined tracepoint() events. that looks
>>>>> to be much trickier since the LTTng tracepoint() functionality relies heavily
>>>>> on (some might say abuses

>>> "abuses" is appropriate ;-)

>>>>> ) the C pre-processor, and Go does not have an equivalent of the C
>>>>> pre-processor. however, i don't see an obvious reason why Go source files that
>>>>> contain tracepoints couldn't be run through the C pre-processor -- except that
>>>>> Go specific LTTng header files would be required.

>>>>> [ https://tour.golang.org/welcome/1 | here is an example of "hello, world" in Go
>>>>> ] . (note the use of "import" rather then "#include").

>>>>> i've spent more than a few hours looking at the C code generated by the C
>>>>> pre-processor trying to track down exactly why a tracepoint() definition is
>>>>> causing a compiler error, so i think i have an idea of just how hard it would
>>>>> be to development equivalent header files for Go + C pre-processor. it may be
>>>>> the case that the Go "header files", once developed, would be compiler
>>>>> specific, i.e only work with [ https://golang.org/doc/install/gccgo | gccgo ]
>>>>> (the gcc front-end for Go).

>>>>> anyway, i'm wondering if anybody has attempted this and/or what your thoughts
>>>>> would be.

>>>> In the case of C/C++ code, using the C preprocessor got the job done without
>>>> requiring any additional
>>>> dependency. Given the context you describe, perhaps it would be wise to consider
>>>> introducing a dedicated
>>>> "lttng probe description" parser. The idea here would be to parse the tracepoint
>>>> probe definitions and
>>>> translate those into native code for various languages (e.g. Golang).

>>>> This would create a new lttng utility that would be required to to produce the
>>>> language-specific files from
>>>> those descriptions. I would allow us to port the "tracepoint" concept to many
>>>> more languages easily, and
>>>> not be so much tied to the C preprocessor anymore.

>>>> So perhaps adding this new tool as a dependency that needs to be invoked prior
>>>> to compilation might
>>>> not be too much of an issue ? I see it as being slightly similar to the role
>>>> accomplished by Flex and
>>>> Bison: they are required to translate from source files to an intermediary
>>>> language, and then the
>>>> resulting files can be included into the distribution source packages, so only
>>>> those who aim at
>>>> changing the source descriptions need to have the translation tool installed.

>>>> Thoughts ?

>>> Good point and we thought about this before. In fact this is just what barectf <
>>> [ http://barectf.org/ | http://barectf.org/ ] > does, for example. What I see
>>> in the future is that a subset of (eventual) CTF 2's metadata language (JSON)
>>> could be used here (or an equivalent, human-friendly YAML, like barectf) to
>>> describe LTTng event and stream classes and translate them to what's needed to
>>> record such events for a given programming language. CTF 2's user attributes
>>> can be used to insert additional, language-specific properties, like parameter
>>> types and names, and other options.

>>> Phil

>>>> Thanks,

>>>> Mathieu

>>>>> --craig

>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_be5a396f-d768-420a-a170-4936d5c70777
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jun 3, 2017, at 3:45 PM, Philippe Proulx &lt;eeppeliteloop@gma=
il.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blo=
ckquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left=
:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote">On Fri, Jun 2, 2017 at 1=
0:24 PM, craig harmer <span dir=3D"ltr">&lt;<a href=3D"mailto:charmster@gma=
il.com" target=3D"_blank">charmster@gmail.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div style=
=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">hi all,<br><br></div><=
div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">the suggestio=
n to write a pre-processor for LTTng tracepoints is interesting and may be =
a good idea.&nbsp; however, i'm not sure that it will provide a general pur=
pose solution.<br><br></div><div style=3D"font-family:&quot;trebuchet ms&qu=
ot;,sans-serif">the problem i for see is that tracepoint invocations, at le=
ast, should be written in the syntax of the language they're being used in =
(a programmer would would expect the tracepoint() function call to look lik=
e any other function call in the language).<br><br>so the tracepoint parser=
 needs to understand the function invocation syntax of each language.&nbsp;=
 it also needs to understand at least some of the rest of the syntax of the=
 language -- in the case of Go it at least needs to be able recognize "impo=
rt" statements and import those files and it needs to understand when somet=
hing that looks like a tracepoint() is actually embedded in a comment or st=
ring.&nbsp; it also needs to emit code that matches the syntax of the langu=
age.<br><br>so a general purpose lttng tracepoint parsing tool would need a=
t least a limited understanding of the syntax and grammar of each language =
for reading the source file in and then writing the source file out.&nbsp; =
there could be code in the middle that's common across languages, but proba=
bly not a lot.&nbsp; perhaps an lttng tracepoint parsing tool could be bett=
er structured as a common framework for language specific tracepoint parser=
s to be plugged in to.<br><br></div><div style=3D"font-family:&quot;trebuch=
et ms&quot;,sans-serif">but writing a parser that actually understands the =
grammar of a language is not easy.&nbsp; if i was really going to do this, =
i'd be tempted to see if i could just take this from gcc (which has front-e=
nds that supports C, C++, Go, and other languages (i think)).<br></div><div=
 style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif"><br></div><div s=
tyle=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">and then there's t=
he tracepoint definitions.&nbsp; they could be written using the barectf() =
tool that Philippe mentions, but i'm not sure if that would be satisfactory=
 for most programmers, who would prefer to write tracepoint definitions in =
the same language that they are programming in.&nbsp; they would also need =
to support the data types of the language (i'm thinking Python here as an e=
xample, where tracepoints would be expected to support most of the Python b=
asic data types).<br></div></div></blockquote><br><div>There's a little mis=
understanding here.</div><br><div>The idea is to have a universal tracepoin=
t definition language (and what I suggested is that a subset of CTF 2, of w=
hich the syntax is JSON (or YAML which translates to JSON directly), could =
be used for this) which translates to functions, classes, macros, etc. in s=
elected programming languages. Depending on the destination language, we ca=
n generate serialization functions directly or wrappers which use LTTng-UST=
 behind the scenes. So in your case, this tool would generate Go source fil=
es which would contain public functions which correspond to tracepoints. We=
 never considered parsing an existing programming language to infer tracepo=
ints.</div><br><div>Of course this requires the developer to define tracepo=
ints in this universal language. That's an additional developing step neede=
d to allow the developer to use tracepoints in his/her favorite language. B=
ut there are other advantages, like generating tracepoints in two different=
 languages from the same tracepoint definitions. Like Mathieu wrote, it's t=
he same spirit as Flex and Bison. With Bison, you don't use the C preproces=
sor to write your grammar rules: the tool reads a Bison input file and gene=
rates a parser source file. Just like barectf reads a YAML configuration fi=
le which defines stream and event classes and generates tracer source files=
.</div></div></div></div></blockquote><div><br></div><div>The problem is th=
at this is often not enough, and we sometimes need to have<br data-mce-bogu=
s=3D"1"></div><div>pre/post code run before/after the serialization to prep=
are the arguments.<br data-mce-bogus=3D"1"></div><div>This happens for inst=
ance in lttng-modules with the LTTNG_TRACEPOINT_EVENT_CODE()<br data-mce-bo=
gus=3D"1"></div><div>macro.<br data-mce-bogus=3D"1"></div><div><br data-mce=
-bogus=3D"1"></div><div>Ideally we should find a way to glue together this =
high-level description<br data-mce-bogus=3D"1"></div><div>and language-nati=
ve helper code.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"=
></div><div>Thoughts ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bogu=
s=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote"><br><div>Phil</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-family=
:&quot;trebuchet ms&quot;,sans-serif"><br></div><div style=3D"font-family:&=
quot;trebuchet ms&quot;,sans-serif"><br></div><div style=3D"font-family:&qu=
ot;trebuchet ms&quot;,sans-serif">because Go seems to be similar to C i'm s=
trongly tempted to just co-opt the C pre-processor and existing LTTng trace=
point machinery and modify the LTTng header files to generate valid Go code=
 for a tracepoint definition.&nbsp; this does add a LTTng tracepoint tool t=
o the steps required to compile Go, except that the tracepoint tool is call=
ed "cpp" (plus header files).<br><br></div><div style=3D"font-family:&quot;=
trebuchet ms&quot;,sans-serif">i don't really know Go yet and i hae not bee=
n assigned to get LTTng to work in Go, so this is all quite preliminary.&nb=
sp; but i think the project i'm about to start on really needs LTTng or LTT=
ng-like tracepoint functionality so i'm motivated to see if this can work.<=
span style=3D"font-family:arial,sans-serif">&nbsp;</span></div></div></bloc=
kquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif"><br></div><di=
v style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">i'm going to in=
vestigate some more.<span class=3D"gmail-m_-6643529984790646395HOEnZb"><spa=
n style=3D"color: #888888;" data-mce-style=3D"color: #888888;" color=3D"#88=
8888"><br></span></span></div><span class=3D"gmail-m_-6643529984790646395HO=
EnZb"><span style=3D"color: #888888;" data-mce-style=3D"color: #888888;" co=
lor=3D"#888888"><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-ser=
if"><br></div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif=
">--craig<br></div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-=
serif"><br></div></span></span></div><div class=3D"gmail-m_-664352998479064=
6395HOEnZb"><div class=3D"gmail-m_-6643529984790646395h5"><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Fri, Jun 2, 2017 at 10:05 AM, P=
hilippe Proulx <span dir=3D"ltr">&lt;<a href=3D"mailto:eeppeliteloop@gmail.=
com" target=3D"_blank">eeppeliteloop@gmail.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_extra"><span><div><div class=3D"gmail-m_-6643529984790646395m_509=
1517559717538205m_790898205284245872gmail_signature">On Fri, Jun 2, 2017 at=
 11:58 AM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathie=
u.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com<=
/a>&gt;</span> wrote:<br></div></div></span><div class=3D"gmail_quote"><spa=
n><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div style=3D"font=
-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><span c=
lass=3D"gmail-m_-6643529984790646395m_5091517559717538205m_7908982052842458=
72gmail-"><br><span id=3D"gmail-m_-6643529984790646395m_5091517559717538205=
m_790898205284245872gmail-m_-5040175781309588822zwchr">----- On Jun 2, 2017=
, at 2:27 AM, craig harmer &lt;<a href=3D"mailto:charmster@gmail.com" targe=
t=3D"_blank">charmster@gmail.com</a>&gt; wrote:<br></span></span><div><span=
 class=3D"gmail-m_-6643529984790646395m_5091517559717538205m_79089820528424=
5872gmail-"><blockquote style=3D"border-left:2px solid rgb(16,16,255);margi=
n-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt"><div dir=3D"ltr"><div style=3D"font-family:&quot;trebuchet ms&quot;=
,sans-serif">hi all,<br><br></div><div style=3D"font-family:&quot;trebuchet=
 ms&quot;,sans-serif">has anyone looked at porting LTTng to <a href=3D"http=
s://en.wikipedia.org/wiki/Go_%28programming_language%29" target=3D"_blank">=
Go</a> (AKA <a href=3D"https://golang.org/" target=3D"_blank">Golang</a>)?<=
/div></div></blockquote><br></span><div>Not yet ! I'm glad someone is looki=
ng into it. :)<br></div><span class=3D"gmail-m_-6643529984790646395m_509151=
7559717538205m_790898205284245872gmail-"><br><blockquote style=3D"border-le=
ft:2px solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,=
0);font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div style=3D"fon=
t-family:&quot;trebuchet ms&quot;,sans-serif"><br><br></div><div style=3D"f=
ont-family:&quot;trebuchet ms&quot;,sans-serif">Go is a language very simil=
ar to C, but it has intrinsic support for concurrency and better memory pro=
tection (at the expense of including garbage collection).&nbsp; its from Go=
ogle and is pretty hot these days for big data and "web scale" distributed =
systems.&nbsp; the similarity to C is not surprising since two of the three=
 authors were also involved in the development of UNIX in at AT&amp;T in th=
e 1970's: Rob Pike and Ken Thompson (Robert Griesemer is the third author).=
<br><br>Go is able to link with C object files, so implementing support for=
 tracef(3) should not be very difficult. <br></div><div style=3D"font-famil=
y:&quot;trebuchet ms&quot;,sans-serif"><br>but i want to have full support =
for user-defined tracepoint() events.&nbsp; that looks to be much trickier =
since the LTTng tracepoint() functionality relies heavily on (some might sa=
y abuses</div></div></blockquote></span></div></div></div></blockquote></sp=
an><div>"abuses" is appropriate ;-)&nbsp;</div><span><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,=
sans-serif;font-size:12pt;color:rgb(0,0,0)"><div><span class=3D"gmail-m_-66=
43529984790646395m_5091517559717538205m_790898205284245872gmail-"><blockquo=
te style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-le=
ft:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoratio=
n:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"l=
tr"><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">) the C =
pre-processor, and Go does not have an equivalent of the C pre-processor.&n=
bsp; however, i don't see an obvious reason why Go source files that contai=
n tracepoints couldn't be run through the C pre-processor -- except that Go=
 specific LTTng header files would be required.<br><br><a href=3D"https://t=
our.golang.org/welcome/1" target=3D"_blank">here is an example of "hello, w=
orld" in Go</a>.&nbsp; (note the use of "import" rather then "#include").<b=
r><br></div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">=
i've spent more than a few hours looking at the C code generated by the C p=
re-processor trying to track down exactly why a tracepoint() definition is =
causing a compiler error, so i think i have an idea of just how hard it wou=
ld be to development equivalent header files for Go + C pre-processor.&nbsp=
; it may be the case that the Go "header files", once developed, would be c=
ompiler specific, i.e only work with <a href=3D"https://golang.org/doc/inst=
all/gccgo" target=3D"_blank">gccgo</a> (the gcc front-end for Go).<br></div=
><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif"><br></div><=
div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">anyway, i'm w=
ondering if anybody has attempted this and/or what your thoughts would be.<=
/div></div></blockquote></span><div>In the case of C/C++ code, using the C =
preprocessor got the job done without requiring any additional<br></div><di=
v>dependency. Given the context you describe, perhaps it would be wise to c=
onsider introducing a dedicated</div><div>"lttng probe description" parser.=
 The idea here would be to parse the tracepoint probe definitions and</div>=
<div>translate those into native code for various languages (e.g. Golang).<=
br></div><br><div>This would create a new lttng utility that would be requi=
red to to produce the language-specific files from</div><div>those descript=
ions. I would allow us to port the "tracepoint" concept to many more langua=
ges easily, and</div><div>not be so much tied to the C preprocessor anymore=
.<span style=3D"font-family:arial,sans-serif;font-size:small;color:rgb(34,3=
4,34)">&nbsp;</span></div></div></div></div></blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div><div style=3D"font-family:arial,helve=
tica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div><br><div>So perhaps a=
dding this new tool as a dependency that needs to be invoked prior to compi=
lation might</div><div>not be too much of an issue ? I see it as being slig=
htly similar to the role accomplished by Flex and<br></div><div>Bison: they=
 are required to translate from source files to an intermediary language, a=
nd then the<br></div><div>resulting files can be included into the distribu=
tion source packages, so only those who aim at<br></div><div>changing the s=
ource descriptions need to have the translation tool installed.<br></div></=
div></div></div></blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12p=
t;color:rgb(0,0,0)"><div><br><div>Thoughts ?<br></div></div></div></div></b=
lockquote><br></span><div>Good point and we thought about this before. In f=
act this is just what barectf &lt;<a href=3D"http://barectf.org/" target=3D=
"_blank">http://barectf.org/</a>&gt;&nbsp;does, for example. What I see in =
the future is that a subset of (eventual) CTF 2's metadata language (JSON) =
could be used here (or an equivalent, human-friendly YAML, like barectf) to=
 describe LTTng event and stream classes and translate them to what's neede=
d to record such events for a given programming language. CTF 2's user attr=
ibutes can be used to insert additional, language-specific properties, like=
 parameter types and names, and other options.</div><br><div>Phil&nbsp;</di=
v><span><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div style=
=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"=
><div><br><div>Thanks,<br></div><br><div>Mathieu<br></div><br><br><br><bloc=
kquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;paddin=
g-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decor=
ation:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr"><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif"><br=
></div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif"><br><=
/div><div style=3D"font-family:&quot;trebuchet ms&quot;,sans-serif">--craig=
<br></div></div><br>_______________________________________________<br>lttn=
g-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=
=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng=
.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lt=
tng.org/cgi-bin/mailman/listinfo/lttng-dev</a><span class=3D"gmail-m_-66435=
29984790646395m_5091517559717538205m_790898205284245872gmail-HOEnZb"><span =
style=3D"color: #888888;" data-mce-style=3D"color: #888888;" color=3D"#8888=
88"><br></span></span></blockquote></div><span class=3D"gmail-m_-6643529984=
790646395m_5091517559717538205m_790898205284245872gmail-HOEnZb"><span style=
=3D"color: #888888;" data-mce-style=3D"color: #888888;" color=3D"#888888"><=
br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"=
http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a><br d=
ata-mce-bogus=3D"1"></div></span></span></div></div><br>___________________=
____________________________<br>
lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" targ=
et=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.ltt=
ng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_bl=
ank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br><br>=
</blockquote></span></div><br></div></div></blockquote></div><br></div></di=
v></div></blockquote></div></div></div><br></blockquote></div><div><br></di=
v><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>=
EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_be5a396f-d768-420a-a170-4936d5c70777--

--===============3772308111029641784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3772308111029641784==--
