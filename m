From: wen qun wang <xiaoxiao046@gmail.com>
Subject: Re: Clang plugin providing automatic application
	instrumentation
Date: Tue, 18 Mar 2014 17:08:19 +0800
Message-ID: <CAJeLfGSAsLmEXr=Nn_mP=BRboP-eTaGG=ciGQnE-3ZOiFb3D0g__41371.8858072118$1395133756$gmane$org@mail.gmail.com>
References: <CAJeLfGT9xKZsrc_WfsY22u-CfqBjR+ry5D+US=g8VJY7XZutmg@mail.gmail.com>
	<CA+jJMxubB8xJBxt6JYVBODC+=iRZbiNPwX4DJU46OajODJ_jfA@mail.gmail.com>
	<CAJeLfGTPDQVBmVmRY_Tdsvm3957QCMgJ0hzva0hEs8g=6t9tCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1000728385=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <xiaoxiao046@gmail.com>) id 1WPq0Y-0007j5-Al
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 05:08:28 -0400
Received: by mail-wi0-f177.google.com with SMTP id cc10so3346274wib.10
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 02:08:20 -0700 (PDT)
In-Reply-To: <CAJeLfGTPDQVBmVmRY_Tdsvm3957QCMgJ0hzva0hEs8g=6t9tCw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1000728385==
Content-Type: multipart/alternative; boundary=089e016347fc99d0f804f4dde08e

--089e016347fc99d0f804f4dde08e
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi,everyone.At first ,thanks for jeremie's help. I have completed toolchain
to gain  an understanding of how the different pieces fit together.Then,
I'm going to through the studying the
demo(/lttng-ust-2.4.0/doc/examples/demo) of lttng-ust to understand the
working principle of lttng.But now,I am in trouble.
In /lttng-ust-2.4.0/doc/examples/demo/demo.c

##################
tracepoint(ust_test_demo2,done,42)
###################

I found the definition of tracepoint in
/lttng-ust-2.4.0/include/lttng/tracepoint.h

############################################################
#define tracepoint(provider, name, ...)    \
do {    \
STAP_PROBEV(provider, name, ## __VA_ARGS__);    \
if (caa_unlikely(__tracepoint_##provider##___##name.state)) \
__tracepoint_cb_##provider##___##name(__VA_ARGS__); \
} while (0)
#################################################################

then i found the definition of
"__tracepoint_cb_##provider##___##name(__VA_ARGS__)" in
/lttng-ust-2.4.0/include/lttng/tracepoint.h line 158

########################################################################
void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__)) \
{ \
struct tracepoint_probe *__tp_probe; \
\
if (caa_unlikely(!TP_RCU_LINK_TEST())) \
return; \
tp_rcu_read_lock_bp(); \
__tp_probe =3D
tp_rcu_dereference_bp(__tracepoint_##_provider##___##_name.probes); \
if (caa_unlikely(!__tp_probe)) \
goto end; \
do { \
void (*__tp_cb)(void) =3D __tp_probe->func; \
void *__tp_data =3D __tp_probe->data; \
\
URCU_FORCE_CAST(void (*)(_TP_ARGS_DATA_PROTO(__VA_ARGS__)), __tp_cb) \
(_TP_ARGS_DATA_VAR(__VA_ARGS__)); \
} while ((++__tp_probe)->func); \
end: \
tp_rcu_read_unlock_bp(); \
}
####################################################################

It seems that "__tracepoint_##_provider##___##_name"  in  "
__tracepoint_##_provider##___##_name.probes" is a struct of tracepoint.
we can found the macro TRACEPOINT_EVENT was used in
"lttng-ust-2.4.0\doc\examples\demo\ust_tests_demo.h".And the struct of
tracepoint was defined by the macro TRACEPOINT_EVENT.But the
__tracepoint_##_provider##___##_name.probes
was set to null.

#################################################
\lttng-ust-2.4.0\include\lttng\tracepoint.h
line 342
#define _DEFINE_TRACEPOINT(_provider, _name, _args) \
extern int __tracepoint_provider_##_provider; \
static const char __tp_strtab_##_provider##___##_name[] \
__attribute__((section("__tracepoints_strings"))) =3D \
#_provider ":" #_name; \
struct tracepoint __tracepoint_##_provider##___##_name \
__attribute__((section("__tracepoints"))) =3D \
{ \
__tp_strtab_##_provider##___##_name, \
0, \
NULL, \---------------------------------------------->here is the probes.
_TRACEPOINT_UNDEFINED_REF(_provider), \
_TP_EXTRACT_STRING(_args), \
{ }, \
}; \
static struct tracepoint * __tracepoint_ptr_##_provider##___##_name \
__attribute__((used, section("__tracepoints_ptrs"))) =3D \
&__tracepoint_##_provider##___##_name;
###################################################################

so i want to know that how the probes of the tracepoint struct  should be
initialized,I can't find the source code.
My english is poor,i hope you can understand what i mean. Thank you very
much.






2014-03-15 9:24 GMT+08:00 =CE=AA=CD=F5 <xiaoxiao046@gmail.com>:

> thank you very much
>
>
> 2014-03-15 1:35 GMT+08:00 J=A8=A6r=A8=A6mie Galarneau <
> jeremie.galarneau@efficios.com>:
>
> On Wed, Mar 12, 2014 at 6:05 AM, =CE=AA=CD=F5 <xiaoxiao046@gmail.com> wro=
te:
>> > Hi All,I am a graduate student from Beijing University of Posts and
>> > Telecommunications. Due to my
>> > experience in windows kernel development and debugging technique,I am
>> very
>> > interested in the lttng project.I want to make a contribution for the
>> Clang
>> > plugin providing automatic application instrumentation after reading t=
he
>> > project ideas for gsoc2014.I am also interested in reverse engineering
>> and
>> > binary hack.
>> > The codes of lttng project have been downloaded for reading.Due to its
>> large
>> > amount,i couldn't figure out a good way to understand it.So,i want to
>> konw
>> > how should i proceed further.
>>
>> You should start by trying the complete toolchain to gain an
>> understanding of how the different pieces fit together. I wouldn't
>> suggest simply jumping into the code.
>>
>> Have a look at the guidelines posted on our GSoC 2014 wiki for more
>> information on how to submit a proposal [1].
>>
>> Let us know if you have more specific questions.
>>
>> J=A8=A6r=A8=A6mie
>>
>> [1]
>> https://bugs.lttng.org/projects/lttng/wiki/Google_Summer_of_Code_2014#Gu=
idelines-for-students-applying-to-GSoC
>>
>> > My english is poor,i hope you can understand what i mean. Thank you ve=
ry
>> > much.
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>>
>>
>>
>> --
>> J=A8=A6r=A8=A6mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>

--089e016347fc99d0f804f4dde08e
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"arial, sans-serif"><span style=3D"font-size:=
14px">Hi,everyone.At first ,thanks for jeremie&#39;s help. I have completed=
 toolchain to gain &nbsp;an understanding of how the different pieces fit t=
ogether.Then, I&#39;m going to through the studying the demo(/lttng-ust-2.4=
.0/doc/examples/demo)&nbsp;of lttng-ust to understand the working principle=
 of lttng.But now,I am in trouble.</span></font><div>
<font face=3D"arial, sans-serif"><span style=3D"font-size:14px">In /lttng-u=
st-2.4.0/doc/examples/demo/demo.c&nbsp;</span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"font-size:14px"><br></span></font></d=
iv><div><font face=3D"arial, sans-serif"><span style=3D"font-size:14px">###=
###############</span></font></div>
<div><font face=3D"arial, sans-serif"><span style=3D"font-size:14px">tracep=
oint(ust_test_demo2,done,42)</span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"font-size:14px">###################</span></font>=
</div>
<div><font face=3D"arial, sans-serif"><span style=3D"font-size:14px"><br></=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"font=
-size:14px">I found the definition of tracepoint in /lttng-ust-2.4.0/includ=
e/lttng/tracepoint.h</span></font></div>
<div><font face=3D"arial, sans-serif"><span style=3D"font-size:14px"><br></=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"font=
-size:14px">############################################################</s=
pan></font></div>
<div><font face=3D"arial, sans-serif"><div style=3D"font-size:14px">#define=
 tracepoint(provider, name, ...)<span class=3D"" style=3D"white-space:pre">=
					</span> &nbsp; &nbsp;\</div><div style=3D"font-size:14px"><span class=
=3D"" style=3D"white-space:pre">	</span>do {<span class=3D"" style=3D"white=
-space:pre">								</span> &nbsp; &nbsp;\</div>
<div style=3D"font-size:14px"><span class=3D"" style=3D"white-space:pre">		=
</span>STAP_PROBEV(provider, name, ## __VA_ARGS__);<span class=3D"" style=
=3D"white-space:pre">		</span> &nbsp; &nbsp;\</div><div style=3D"font-size:=
14px"><span class=3D"" style=3D"white-space:pre">		</span>if (caa_unlikely(=
__tracepoint_##provider##___##name.state)) \</div>
<div style=3D"font-size:14px"><span class=3D"" style=3D"white-space:pre">		=
	</span>__tracepoint_cb_##provider##___##name(__VA_ARGS__); \</div><div sty=
le=3D"font-size:14px"><span class=3D"" style=3D"white-space:pre">	</span>} =
while (0)</div>
<div style=3D"font-size:14px">#############################################=
####################</div><div style=3D"font-size:14px"><br></div><div styl=
e=3D"font-size:14px">then i found the definition of &quot;__tracepoint_cb_#=
#provider##___##name(__VA_ARGS__)&quot; in /lttng-ust-2.4.0/include/lttng/t=
racepoint.h line 158</div>
</font><font face=3D"arial, sans-serif"><div><div><span style=3D"font-size:=
14px"><br></span></div><div><span style=3D"font-size:14px">################=
########################################################</span></div><div><=
span style=3D"font-size:14px">void __tracepoint_cb_##_provider##___##_name(=
_TP_ARGS_PROTO(__VA_ARGS__))<span class=3D"" style=3D"white-space:pre">		</=
span>\</span></div>
<div><span style=3D"font-size:14px">{<span class=3D"" style=3D"white-space:=
pre">											</span>\</span></div><div><span style=3D"font-size:14px"><s=
pan class=3D"" style=3D"white-space:pre">	</span>struct tracepoint_probe *_=
_tp_probe;<span class=3D"" style=3D"white-space:pre">						</span>\</span><=
/div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">											</span>\</span></div><div><span style=3D"font-size:14px"><sp=
an class=3D"" style=3D"white-space:pre">	</span>if (caa_unlikely(!TP_RCU_LI=
NK_TEST()))<span class=3D"" style=3D"white-space:pre">						</span>\</span>=
</div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">		</span>return;<span class=3D"" style=3D"white-space:pre">									</s=
pan>\</span></div><div><span style=3D"font-size:14px"><span class=3D"" styl=
e=3D"white-space:pre">	</span>tp_rcu_read_lock_bp();<span class=3D"" style=
=3D"white-space:pre">								</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">	</span>__tp_probe =3D tp_rcu_dereference_bp(__tracepoint_##_provider##=
___##_name.probes); \</span></div><div><span style=3D"font-size:14px"><span=
 class=3D"" style=3D"white-space:pre">	</span>if (caa_unlikely(!__tp_probe)=
)<span class=3D"" style=3D"white-space:pre">							</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">		</span>goto end;<span class=3D"" style=3D"white-space:pre">								</=
span>\</span></div><div><span style=3D"font-size:14px"><span class=3D"" sty=
le=3D"white-space:pre">	</span>do {<span class=3D"" style=3D"white-space:pr=
e">										</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">		</span>void (*__tp_cb)(void) =3D __tp_probe-&gt;func;<span class=3D""=
 style=3D"white-space:pre">					</span>\</span></div><div><span style=3D"fo=
nt-size:14px"><span class=3D"" style=3D"white-space:pre">		</span>void *__t=
p_data =3D __tp_probe-&gt;data;<span class=3D"" style=3D"white-space:pre">	=
				</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">											</span>\</span></div><div><span style=3D"font-size:14px"><sp=
an class=3D"" style=3D"white-space:pre">		</span>URCU_FORCE_CAST(void (*)(_=
TP_ARGS_DATA_PROTO(__VA_ARGS__)), __tp_cb)<span class=3D"" style=3D"white-s=
pace:pre">	</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">				</span>(_TP_ARGS_DATA_VAR(__VA_ARGS__));<span class=3D"" style=3D"w=
hite-space:pre">			</span>\</span></div><div><span style=3D"font-size:14px"=
><span class=3D"" style=3D"white-space:pre">	</span>} while ((++__tp_probe)=
-&gt;func);<span class=3D"" style=3D"white-space:pre">							</span>\</span=
></div>
<div><span style=3D"font-size:14px">end:<span class=3D"" style=3D"white-spa=
ce:pre">											</span>\</span></div><div><span style=3D"font-size:14px"=
><span class=3D"" style=3D"white-space:pre">	</span>tp_rcu_read_unlock_bp()=
;<span class=3D"" style=3D"white-space:pre">							</span>\</span></div>
<div><span style=3D"font-size:14px">}</span></div><div><span style=3D"font-=
size:14px"><span class=3D"" style=3D"white-space:pre">#####################=
###############################################	</span></span></div></div><=
div>
<span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:pre"><=
br></span></span></div><div><span style=3D"font-size:14px"><span class=3D""=
 style=3D"white-space:pre">It seems that &quot;</span></span><span style=3D=
"font-size:14px">__tracepoint_##_provider##___##_name&quot; &nbsp;in &nbsp;=
&quot;</span><span style=3D"font-size:14px">__tracepoint_##_provider##___##=
_name.probes&quot;&nbsp;</span><span style=3D"font-size:14px">is a struct o=
f tracepoint.</span></div>
<div><span style=3D"font-size:14px">we can found the macro&nbsp;TRACEPOINT_=
EVENT was used in &quot;lttng-ust-2.4.0\doc\examples\demo\ust_tests_demo.h&=
quot;.And the struct of tracepoint was defined by the&nbsp;</span><span sty=
le=3D"font-size:14px">macro&nbsp;TRACEPOINT_EVENT.But the&nbsp;</span><span=
 style=3D"font-size:14px">__tracepoint_##_provider##___##_name.probes was s=
et to null.</span></div>
<div><span style=3D"font-size:14px"><br></span></div><div><span style=3D"fo=
nt-size:14px">#################################################&nbsp;\lttng=
-ust-2.4.0\include\lttng\tracepoint.h line 342</span></div><div><div><span =
style=3D"font-size:14px">#define _DEFINE_TRACEPOINT(_provider, _name, _args=
)<span class=3D"" style=3D"white-space:pre">				</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">	</span>extern int __tracepoint_provider_##_provider; <span class=3D"" =
style=3D"white-space:pre">				</span>\</span></div><div><span style=3D"font=
-size:14px"><span class=3D"" style=3D"white-space:pre">	</span>static const=
 char __tp_strtab_##_provider##___##_name[]<span class=3D"" style=3D"white-=
space:pre">			</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">		</span>__attribute__((section(&quot;__tracepoints_strings&quot;))) =
=3D<span class=3D"" style=3D"white-space:pre">		</span>\</span></div><div><=
span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:pre">		=
	</span>#_provider &quot;:&quot; #_name;<span class=3D"" style=3D"white-spa=
ce:pre">					</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">	</span>struct tracepoint __tracepoint_##_provider##___##_name<span cla=
ss=3D"" style=3D"white-space:pre">			</span>\</span></div><div><span style=
=3D"font-size:14px"><span class=3D"" style=3D"white-space:pre">		</span>__a=
ttribute__((section(&quot;__tracepoints&quot;))) =3D<span class=3D"" style=
=3D"white-space:pre">			</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">		</span>{<span class=3D"" style=3D"white-space:pre">								</span>\</=
span></div><div><span style=3D"font-size:14px"><span class=3D"" style=3D"wh=
ite-space:pre">			</span>__tp_strtab_##_provider##___##_name,<span class=3D=
"" style=3D"white-space:pre">			</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">			</span>0,<span class=3D"" style=3D"white-space:pre">							</span>\<=
/span></div><div><span style=3D"font-size:14px"><span class=3D"" style=3D"w=
hite-space:pre">			</span>NULL,<span class=3D"" style=3D"white-space:pre">	=
						</span>\----------------------------------------------&gt;here is the=
 probes.</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">			</span>_TRACEPOINT_UNDEFINED_REF(_provider), <span class=3D"" style=
=3D"white-space:pre">			</span>\</span></div><div><span style=3D"font-size:=
14px"><span class=3D"" style=3D"white-space:pre">			</span>_TP_EXTRACT_STRI=
NG(_args),<span class=3D"" style=3D"white-space:pre">				</span>\</span></d=
iv>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">			</span>{ },<span class=3D"" style=3D"white-space:pre">							</span>=
\</span></div><div><span style=3D"font-size:14px"><span class=3D"" style=3D=
"white-space:pre">		</span>};<span class=3D"" style=3D"white-space:pre">			=
					</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">	</span>static struct tracepoint * __tracepoint_ptr_##_provider##___##_=
name<span class=3D"" style=3D"white-space:pre">	</span>\</span></div><div><=
span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:pre">		=
</span>__attribute__((used, section(&quot;__tracepoints_ptrs&quot;))) =3D<s=
pan class=3D"" style=3D"white-space:pre">		</span>\</span></div>
<div><span style=3D"font-size:14px"><span class=3D"" style=3D"white-space:p=
re">			</span>&amp;__tracepoint_##_provider##___##_name;</span></div></div>=
<div><span style=3D"font-size:14px">#######################################=
############################</span></div>
<div><span style=3D"font-size:14px"><br></span></div><div><span style=3D"fo=
nt-size:14px">so i want to know that how the probes of the tracepoint struc=
t &nbsp;should be initialized,I can&#39;t find the source code.</span></div=
><div>
<span style=3D"color:rgb(84,84,84);font-size:14px;line-height:18px">My engl=
ish is poor,i hope you can understand what i mean. Thank you very much.&nbs=
p;</span><span style=3D"font-size:14px"><br></span></div><div><span style=
=3D"font-size:14px"><br>
</span></div><div><span style=3D"font-size:14px"><br></span></div><div><spa=
n style=3D"font-size:14px"><br></span></div><div><span style=3D"font-size:1=
4px"><br></span></div></font></div></div><div class=3D"gmail_extra"><br><br=
><div class=3D"gmail_quote">
2014-03-15 9:24 GMT+08:00 =CE=AA=CD=F5 <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:xiaoxiao046@gmail.com" target=3D"_blank">xiaoxiao046@gmail.com</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">
<div dir=3D"ltr">thank you very much</div><div class=3D"gmail_extra"><br><b=
r><div class=3D"gmail_quote">2014-03-15 1:35 GMT+08:00 J=A8=A6r=A8=A6mie Ga=
larneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.=
com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span>:<div>
<div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On Wed, Mar 12, 2014 at 6:05 AM, =CE=AA=
=CD=F5 &lt;<a href=3D"mailto:xiaoxiao046@gmail.com" target=3D"_blank">xiaox=
iao046@gmail.com</a>&gt; wrote:<br>


&gt; Hi All,I am a graduate student from Beijing University of Posts and<br=
>
&gt; Telecommunications. Due to my<br>
&gt; experience in windows kernel development and debugging technique,I am =
very<br>
&gt; interested in the lttng project.I want to make a contribution for the =
Clang<br>
&gt; plugin providing automatic application instrumentation after reading t=
he<br>
&gt; project ideas for gsoc2014.I am also interested in reverse engineering=
 and<br>
&gt; binary hack.<br>
&gt; The codes of lttng project have been downloaded for reading.Due to its=
 large<br>
&gt; amount,i couldn&#39;t figure out a good way to understand it.So,i want=
 to konw<br>
&gt; how should i proceed further.<br>
<br>
</div>You should start by trying the complete toolchain to gain an<br>
understanding of how the different pieces fit together. I wouldn&#39;t<br>
suggest simply jumping into the code.<br>
<br>
Have a look at the guidelines posted on our GSoC 2014 wiki for more<br>
information on how to submit a proposal [1].<br>
<br>
Let us know if you have more specific questions.<br>
<br>
J=A8=A6r=A8=A6mie<br>
<br>
[1] <a href=3D"https://bugs.lttng.org/projects/lttng/wiki/Google_Summer_of_=
Code_2014#Guidelines-for-students-applying-to-GSoC" target=3D"_blank">https=
://bugs.lttng.org/projects/lttng/wiki/Google_Summer_of_Code_2014#Guidelines=
-for-students-applying-to-GSoC</a><br>


<div><br>
&gt; My english is poor,i hope you can understand what i mean. Thank you ve=
ry<br>
&gt; much.<br>
&gt;<br>
</div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<span><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=A8=A6r=A8=A6mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div></div></div><br></div>
</blockquote></div><br></div>

--089e016347fc99d0f804f4dde08e--


--===============1000728385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1000728385==--
