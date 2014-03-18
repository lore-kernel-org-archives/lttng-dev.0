From: wen qun wang <xiaoxiao046@gmail.com>
Subject: Re: Clang plugin providing automatic application
	instrumentation
Date: Tue, 18 Mar 2014 20:37:49 +0800
Message-ID: <CAJeLfGR34V_GXUZ=2wkrtm1Hps6OiQvE5PcWvjnm=mR4x23f+A__37285.935591399$1395146316$gmane$org@mail.gmail.com>
References: <CAJeLfGT9xKZsrc_WfsY22u-CfqBjR+ry5D+US=g8VJY7XZutmg@mail.gmail.com>
	<CA+jJMxubB8xJBxt6JYVBODC+=iRZbiNPwX4DJU46OajODJ_jfA@mail.gmail.com>
	<CAJeLfGTPDQVBmVmRY_Tdsvm3957QCMgJ0hzva0hEs8g=6t9tCw@mail.gmail.com>
	<CAJeLfGSAsLmEXr=Nn_mP=BRboP-eTaGG=ciGQnE-3ZOiFb3D0g@mail.gmail.com>
	<CAJ7wx-GDgK23JHAqpYFt=U2zGyDe2Eip950t=NQR1VtR+Kon3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0757455323=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <xiaoxiao046@gmail.com>) id 1WPtHI-0001BX-1W
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 08:37:58 -0400
Received: by mail-wg0-f52.google.com with SMTP id k14so5777211wgh.23
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 05:37:50 -0700 (PDT)
In-Reply-To: <CAJ7wx-GDgK23JHAqpYFt=U2zGyDe2Eip950t=NQR1VtR+Kon3w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <zifeitong@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0757455323==
Content-Type: multipart/alternative; boundary=f46d04428e70d2a00504f4e0cda7

--f46d04428e70d2a00504f4e0cda7
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Thanks for your help.
It seems that set_tracepoint is called by the void
__tracepoint_register_##_provider##___##_name(\lttng-ust-2.4.0\include\lttn=
g\tracepoint.h
line 182).
But there is no function which invoke the function
__tracepoint_register_##_provider##___##_name,so when is the function
__tracepoint_register_##_provider##___##_name is called?


2014-03-18 19:55 GMT+08:00 Zifei Tong <zifeitong@gmail.com>:

> Hi,
>
> Please check the set_tracepoint() function in liblttng-ust/tracepoint.c
>
>     /*
>      * Sets the probe callback corresponding to one tracepoint.
>      */
>     static void set_tracepoint(struct tracepoint_entry **entry, struct
> tracepoint *elem, int active);
>
> I think probes are connected to tracepoints when user enable
> corresponding events.
>
> Hope that helps.
>
> Zifei Tong
>
> On Tue, Mar 18, 2014 at 5:08 PM, wen qun wang <xiaoxiao046@gmail.com>
> wrote:
> > Hi,everyone.At first ,thanks for jeremie's help. I have completed
> toolchain
> > to gain  an understanding of how the different pieces fit together.Then=
,
> I'm
> > going to through the studying the
> demo(/lttng-ust-2.4.0/doc/examples/demo)
> > of lttng-ust to understand the working principle of lttng.But now,I am =
in
> > trouble.
> > In /lttng-ust-2.4.0/doc/examples/demo/demo.c
> >
> > ##################
> > tracepoint(ust_test_demo2,done,42)
> > ###################
> >
> > I found the definition of tracepoint in
> > /lttng-ust-2.4.0/include/lttng/tracepoint.h
> >
> > ############################################################
> > #define tracepoint(provider, name, ...)    \
> > do {    \
> > STAP_PROBEV(provider, name, ## __VA_ARGS__);    \
> > if (caa_unlikely(__tracepoint_##provider##___##name.state)) \
> > __tracepoint_cb_##provider##___##name(__VA_ARGS__); \
> > } while (0)
> > #################################################################
> >
> > then i found the definition of
> > "__tracepoint_cb_##provider##___##name(__VA_ARGS__)" in
> > /lttng-ust-2.4.0/include/lttng/tracepoint.h line 158
> >
> > #######################################################################=
#
> > void
> __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__)) \
> > { \
> > struct tracepoint_probe *__tp_probe; \
> > \
> > if (caa_unlikely(!TP_RCU_LINK_TEST())) \
> > return; \
> > tp_rcu_read_lock_bp(); \
> > __tp_probe =3D
> > tp_rcu_dereference_bp(__tracepoint_##_provider##___##_name.probes); \
> > if (caa_unlikely(!__tp_probe)) \
> > goto end; \
> > do { \
> > void (*__tp_cb)(void) =3D __tp_probe->func; \
> > void *__tp_data =3D __tp_probe->data; \
> > \
> > URCU_FORCE_CAST(void (*)(_TP_ARGS_DATA_PROTO(__VA_ARGS__)), __tp_cb) \
> > (_TP_ARGS_DATA_VAR(__VA_ARGS__)); \
> > } while ((++__tp_probe)->func); \
> > end: \
> > tp_rcu_read_unlock_bp(); \
> > }
> > ####################################################################
> >
> > It seems that "__tracepoint_##_provider##___##_name"  in
> > "__tracepoint_##_provider##___##_name.probes" is a struct of tracepoint=
.
> > we can found the macro TRACEPOINT_EVENT was used in
> > "lttng-ust-2.4.0\doc\examples\demo\ust_tests_demo.h".And the struct of
> > tracepoint was defined by the macro TRACEPOINT_EVENT.But the
> > __tracepoint_##_provider##___##_name.probes was set to null.
> >
> > #################################################
> > \lttng-ust-2.4.0\include\lttng\tracepoint.h line 342
> > #define _DEFINE_TRACEPOINT(_provider, _name, _args) \
> > extern int __tracepoint_provider_##_provider; \
> > static const char __tp_strtab_##_provider##___##_name[] \
> > __attribute__((section("__tracepoints_strings"))) =3D \
> > #_provider ":" #_name; \
> > struct tracepoint __tracepoint_##_provider##___##_name \
> > __attribute__((section("__tracepoints"))) =3D \
> > { \
> > __tp_strtab_##_provider##___##_name, \
> > 0, \
> > NULL, \---------------------------------------------->here is the probe=
s.
> > _TRACEPOINT_UNDEFINED_REF(_provider), \
> > _TP_EXTRACT_STRING(_args), \
> > { }, \
> > }; \
> > static struct tracepoint * __tracepoint_ptr_##_provider##___##_name \
> > __attribute__((used, section("__tracepoints_ptrs"))) =3D \
> > &__tracepoint_##_provider##___##_name;
> > ###################################################################
> >
> > so i want to know that how the probes of the tracepoint struct  should =
be
> > initialized,I can't find the source code.
> > My english is poor,i hope you can understand what i mean. Thank you ver=
y
> > much.
> >
> >
> >
> >
> >
> >
> > 2014-03-15 9:24 GMT+08:00 =CE=AA=CD=F5 <xiaoxiao046@gmail.com>:
> >>
> >> thank you very much
> >>
> >>
> >> 2014-03-15 1:35 GMT+08:00 J=A8=A6r=A8=A6mie Galarneau
> >> <jeremie.galarneau@efficios.com>:
> >>
> >>> On Wed, Mar 12, 2014 at 6:05 AM, =CE=AA=CD=F5 <xiaoxiao046@gmail.com>=
 wrote:
> >>> > Hi All,I am a graduate student from Beijing University of Posts and
> >>> > Telecommunications. Due to my
> >>> > experience in windows kernel development and debugging technique,I =
am
> >>> > very
> >>> > interested in the lttng project.I want to make a contribution for t=
he
> >>> > Clang
> >>> > plugin providing automatic application instrumentation after readin=
g
> >>> > the
> >>> > project ideas for gsoc2014.I am also interested in reverse
> engineering
> >>> > and
> >>> > binary hack.
> >>> > The codes of lttng project have been downloaded for reading.Due to
> its
> >>> > large
> >>> > amount,i couldn't figure out a good way to understand it.So,i want =
to
> >>> > konw
> >>> > how should i proceed further.
> >>>
> >>> You should start by trying the complete toolchain to gain an
> >>> understanding of how the different pieces fit together. I wouldn't
> >>> suggest simply jumping into the code.
> >>>
> >>> Have a look at the guidelines posted on our GSoC 2014 wiki for more
> >>> information on how to submit a proposal [1].
> >>>
> >>> Let us know if you have more specific questions.
> >>>
> >>> J=A8=A6r=A8=A6mie
> >>>
> >>> [1]
> >>>
> https://bugs.lttng.org/projects/lttng/wiki/Google_Summer_of_Code_2014#Gui=
delines-for-students-applying-to-GSoC
> >>>
> >>> > My english is poor,i hope you can understand what i mean. Thank you
> >>> > very
> >>> > much.
> >>> >
> >>> > _______________________________________________
> >>> > lttng-dev mailing list
> >>> > lttng-dev@lists.lttng.org
> >>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>> >
> >>>
> >>>
> >>>
> >>> --
> >>> J=A8=A6r=A8=A6mie Galarneau
> >>> EfficiOS Inc.
> >>> http://www.efficios.com
> >>
> >>
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--f46d04428e70d2a00504f4e0cda7
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for your help.<div>It seems that set_tracepoint is =
called by the&nbsp;void __tracepoint_register_##_provider##___##_name(\lttn=
g-ust-2.4.0\include\lttng\tracepoint.h line 182).</div><div>But there is no=
 function which invoke the function __tracepoint_register_##_provider##___#=
#_name,so when is the function __tracepoint_register_##_provider##___##_nam=
e is called?</div>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2014-03=
-18 19:55 GMT+08:00 Zifei Tong <span dir=3D"ltr">&lt;<a href=3D"mailto:zife=
itong@gmail.com" target=3D"_blank">zifeitong@gmail.com</a>&gt;</span>:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
Hi,<br>
<br>
Please check the set_tracepoint() function in liblttng-ust/tracepoint.c<br>
<br>
&nbsp; &nbsp; /*<br>
&nbsp; &nbsp; &nbsp;* Sets the probe callback corresponding to one tracepoi=
nt.<br>
&nbsp; &nbsp; &nbsp;*/<br>
&nbsp; &nbsp; static void set_tracepoint(struct tracepoint_entry **entry, s=
truct<br>
tracepoint *elem, int active);<br>
<br>
I think probes are connected to tracepoints when user enable<br>
corresponding events.<br>
<br>
Hope that helps.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Zifei Tong<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
On Tue, Mar 18, 2014 at 5:08 PM, wen qun wang &lt;<a href=3D"mailto:xiaoxia=
o046@gmail.com">xiaoxiao046@gmail.com</a>&gt; wrote:<br>
&gt; Hi,everyone.At first ,thanks for jeremie&#39;s help. I have completed =
toolchain<br>
&gt; to gain &nbsp;an understanding of how the different pieces fit togethe=
r.Then, I&#39;m<br>
&gt; going to through the studying the demo(/lttng-ust-2.4.0/doc/examples/d=
emo)<br>
&gt; of lttng-ust to understand the working principle of lttng.But now,I am=
 in<br>
&gt; trouble.<br>
&gt; In /lttng-ust-2.4.0/doc/examples/demo/demo.c<br>
&gt;<br>
&gt; ##################<br>
&gt; tracepoint(ust_test_demo2,done,42)<br>
&gt; ###################<br>
&gt;<br>
&gt; I found the definition of tracepoint in<br>
&gt; /lttng-ust-2.4.0/include/lttng/tracepoint.h<br>
&gt;<br>
&gt; ############################################################<br>
&gt; #define tracepoint(provider, name, ...) &nbsp; &nbsp;\<br>
&gt; do { &nbsp; &nbsp;\<br>
&gt; STAP_PROBEV(provider, name, ## __VA_ARGS__); &nbsp; &nbsp;\<br>
&gt; if (caa_unlikely(__tracepoint_##provider##___##name.state)) \<br>
&gt; __tracepoint_cb_##provider##___##name(__VA_ARGS__); \<br>
&gt; } while (0)<br>
&gt; #################################################################<br>
&gt;<br>
&gt; then i found the definition of<br>
&gt; &quot;__tracepoint_cb_##provider##___##name(__VA_ARGS__)&quot; in<br>
&gt; /lttng-ust-2.4.0/include/lttng/tracepoint.h line 158<br>
&gt;<br>
&gt; ######################################################################=
##<br>
&gt; void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS_=
_)) \<br>
&gt; { \<br>
&gt; struct tracepoint_probe *__tp_probe; \<br>
&gt; \<br>
&gt; if (caa_unlikely(!TP_RCU_LINK_TEST())) \<br>
&gt; return; \<br>
&gt; tp_rcu_read_lock_bp(); \<br>
&gt; __tp_probe =3D<br>
&gt; tp_rcu_dereference_bp(__tracepoint_##_provider##___##_name.probes); \<=
br>
&gt; if (caa_unlikely(!__tp_probe)) \<br>
&gt; goto end; \<br>
&gt; do { \<br>
&gt; void (*__tp_cb)(void) =3D __tp_probe-&gt;func; \<br>
&gt; void *__tp_data =3D __tp_probe-&gt;data; \<br>
&gt; \<br>
&gt; URCU_FORCE_CAST(void (*)(_TP_ARGS_DATA_PROTO(__VA_ARGS__)), __tp_cb) \=
<br>
&gt; (_TP_ARGS_DATA_VAR(__VA_ARGS__)); \<br>
&gt; } while ((++__tp_probe)-&gt;func); \<br>
&gt; end: \<br>
&gt; tp_rcu_read_unlock_bp(); \<br>
&gt; }<br>
&gt; ####################################################################<b=
r>
&gt;<br>
&gt; It seems that &quot;__tracepoint_##_provider##___##_name&quot; &nbsp;i=
n<br>
&gt; &quot;__tracepoint_##_provider##___##_name.probes&quot; is a struct of=
 tracepoint.<br>
&gt; we can found the macro TRACEPOINT_EVENT was used in<br>
&gt; &quot;lttng-ust-2.4.0\doc\examples\demo\ust_tests_demo.h&quot;.And the=
 struct of<br>
&gt; tracepoint was defined by the macro TRACEPOINT_EVENT.But the<br>
&gt; __tracepoint_##_provider##___##_name.probes was set to null.<br>
&gt;<br>
&gt; #################################################<br>
&gt; \lttng-ust-2.4.0\include\lttng\tracepoint.h line 342<br>
&gt; #define _DEFINE_TRACEPOINT(_provider, _name, _args) \<br>
&gt; extern int __tracepoint_provider_##_provider; \<br>
&gt; static const char __tp_strtab_##_provider##___##_name[] \<br>
&gt; __attribute__((section(&quot;__tracepoints_strings&quot;))) =3D \<br>
&gt; #_provider &quot;:&quot; #_name; \<br>
&gt; struct tracepoint __tracepoint_##_provider##___##_name \<br>
&gt; __attribute__((section(&quot;__tracepoints&quot;))) =3D \<br>
&gt; { \<br>
&gt; __tp_strtab_##_provider##___##_name, \<br>
&gt; 0, \<br>
&gt; NULL, \----------------------------------------------&gt;here is the p=
robes.<br>
&gt; _TRACEPOINT_UNDEFINED_REF(_provider), \<br>
&gt; _TP_EXTRACT_STRING(_args), \<br>
&gt; { }, \<br>
&gt; }; \<br>
&gt; static struct tracepoint * __tracepoint_ptr_##_provider##___##_name \<=
br>
&gt; __attribute__((used, section(&quot;__tracepoints_ptrs&quot;))) =3D \<b=
r>
&gt; &amp;__tracepoint_##_provider##___##_name;<br>
&gt; ###################################################################<br=
>
&gt;<br>
&gt; so i want to know that how the probes of the tracepoint struct &nbsp;s=
hould be<br>
&gt; initialized,I can&#39;t find the source code.<br>
&gt; My english is poor,i hope you can understand what i mean. Thank you ve=
ry<br>
&gt; much.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; 2014-03-15 9:24 GMT+08:00 =CE=AA=CD=F5 &lt;<a href=3D"mailto:xiaoxiao0=
46@gmail.com">xiaoxiao046@gmail.com</a>&gt;:<br>
&gt;&gt;<br>
&gt;&gt; thank you very much<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; 2014-03-15 1:35 GMT+08:00 J=A8=A6r=A8=A6mie Galarneau<br>
&gt;&gt; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.gala=
rneau@efficios.com</a>&gt;:<br>
&gt;&gt;<br>
&gt;&gt;&gt; On Wed, Mar 12, 2014 at 6:05 AM, =CE=AA=CD=F5 &lt;<a href=3D"m=
ailto:xiaoxiao046@gmail.com">xiaoxiao046@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt; &gt; Hi All,I am a graduate student from Beijing University of=
 Posts and<br>
&gt;&gt;&gt; &gt; Telecommunications. Due to my<br>
&gt;&gt;&gt; &gt; experience in windows kernel development and debugging te=
chnique,I am<br>
&gt;&gt;&gt; &gt; very<br>
&gt;&gt;&gt; &gt; interested in the lttng project.I want to make a contribu=
tion for the<br>
&gt;&gt;&gt; &gt; Clang<br>
&gt;&gt;&gt; &gt; plugin providing automatic application instrumentation af=
ter reading<br>
&gt;&gt;&gt; &gt; the<br>
&gt;&gt;&gt; &gt; project ideas for gsoc2014.I am also interested in revers=
e engineering<br>
&gt;&gt;&gt; &gt; and<br>
&gt;&gt;&gt; &gt; binary hack.<br>
&gt;&gt;&gt; &gt; The codes of lttng project have been downloaded for readi=
ng.Due to its<br>
&gt;&gt;&gt; &gt; large<br>
&gt;&gt;&gt; &gt; amount,i couldn&#39;t figure out a good way to understand=
 it.So,i want to<br>
&gt;&gt;&gt; &gt; konw<br>
&gt;&gt;&gt; &gt; how should i proceed further.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You should start by trying the complete toolchain to gain an<b=
r>
&gt;&gt;&gt; understanding of how the different pieces fit together. I woul=
dn&#39;t<br>
&gt;&gt;&gt; suggest simply jumping into the code.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Have a look at the guidelines posted on our GSoC 2014 wiki for=
 more<br>
&gt;&gt;&gt; information on how to submit a proposal [1].<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Let us know if you have more specific questions.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; J=A8=A6r=A8=A6mie<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [1]<br>
&gt;&gt;&gt; <a href=3D"https://bugs.lttng.org/projects/lttng/wiki/Google_S=
ummer_of_Code_2014#Guidelines-for-students-applying-to-GSoC" target=3D"_bla=
nk">https://bugs.lttng.org/projects/lttng/wiki/Google_Summer_of_Code_2014#G=
uidelines-for-students-applying-to-GSoC</a><br>

&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt; My english is poor,i hope you can understand what i mean.=
 Thank you<br>
&gt;&gt;&gt; &gt; very<br>
&gt;&gt;&gt; &gt; much.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; _______________________________________________<br>
&gt;&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@li=
sts.lttng.org</a><br>
&gt;&gt;&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</a><br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; J=A8=A6r=A8=A6mie Galarneau<br>
&gt;&gt;&gt; EfficiOS Inc.<br>
&gt;&gt;&gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://w=
ww.efficios.com</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
</div></div></blockquote></div><br></div>

--f46d04428e70d2a00504f4e0cda7--


--===============0757455323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0757455323==--
