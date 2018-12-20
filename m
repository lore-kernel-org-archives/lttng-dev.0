From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: TP_ARGS for TRACEPOINT_EVENT_CLASS and
 TRACEPOINT_EVENT_INSTANCE
Date: Thu, 20 Dec 2018 14:28:08 -0500 (EST)
Message-ID: <281166750.7024.1545334088913.JavaMail.zimbra__5957.44975512407$1545333973$gmane$org@efficios.com>
References: <CACJEY862Ytj85N+sidwaq1JEQ+FCiAFo7x5JGuTb992mUrYkdg@mail.gmail.com>
 <CAB4xu_0JxAfA9QtU-NHgtoTOh6c_eT+zQPBvXNr_HZgKE6GvWA@mail.gmail.com>
 <CACJEY84HU4jdKWdo_6ZJO88MYhHN7XvQ-2uDSQAjE-6L06zwiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9185042519307266054=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43LMHG3524z16Th
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 14:28:10 -0500 (EST)
In-Reply-To: <CACJEY84HU4jdKWdo_6ZJO88MYhHN7XvQ-2uDSQAjE-6L06zwiw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yonghong Yan <yanyh15@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============9185042519307266054==
Content-Type: multipart/alternative;
	boundary="=_8703ba5a-2c4a-4bdd-9d55-e6d8fe5bc3df"

--=_8703ba5a-2c4a-4bdd-9d55-e6d8fe5bc3df
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This is due to limitations of the C preprocessor. We need to have the TP_ARGS() available 
both in the TRACEPOINT_EVENT_INSTANCE(), which generates the tracepoint prototype 
used to validate type compability of the tracepoint callsite within the application, and within 
TRACEPOINT_EVENT_CLASS() which is used to generate the probe callback with the 
correct arguments. 

Unfortunately, the C preprocessor does not allow much freedom when it comes to accessing 
arguments of another macro. 

Thanks, 

Mathieu 

----- On Dec 20, 2018, at 12:21 PM, Yonghong Yan <yanyh15@gmail.com> wrote: 

> Then why bother to require to have the TP_ARGS in TRACEPOINT_EVENT_INSTANCE?

> Yonghong

> On Thu, Dec 20, 2018 at 11:56 AM Philippe Proulx < [
> mailto:eeppeliteloop@gmail.com | eeppeliteloop@gmail.com ] > wrote:

>> On Thu, Dec 20, 2018 at 11:47 AM Yonghong Yan < [ mailto:yanyh15@gmail.com |
>> yanyh15@gmail.com ] > wrote:

>>> I am looking at the following example from lttng-ust manual. The same TP_ARGS (
>>> ... ) are repeated in both the TRACEPOINT_EVENT_CLASS and
>>> TRACEPOINT_EVENT_INSTANCE definition. My understanding is that it actually
>>> allows using different arguments, even in this example it is the same. Am I
>> > right?

>> No it does not: they need to match.

>> See < [
>> https://github.com/lttng/lttng-ust/commit/c75c0422c64f33c0102e1778cecc812c58b700e5
>> |
>> https://github.com/lttng/lttng-ust/commit/c75c0422c64f33c0102e1778cecc812c58b700e5
>> ] >.

>> Phil


>>> I also like the feature of having one TP_ARGS in the TRACEPOINT_EVENT_CLASS that
>>> declares the arguments for several TRACEPOINT_EVENT_INSTANCE so we do not need
>> > to have TP_ARGS in TRACEPOINT_EVENT_INSTANCE. Is that possible?

>> > Thank you
>> > Yonghong

>> > TRACEPOINT_EVENT_CLASS(
>> > my_provider,
>> > my_tracepoint_class,
>> > TP_ARGS(
>> > int, my_integer_arg,
>> > struct app_struct *, app_struct_arg
>> > ),
>> > TP_FIELDS(
>> > ctf_integer(int, a, my_integer_arg)
>> > ctf_integer(unsigned long, b, app_struct_arg->b)
>> > ctf_string(c, app_struct_arg->c)
>> > )
>> > )

>> > TRACEPOINT_EVENT_INSTANCE(
>> > my_provider,
>> > my_tracepoint_class,
>> > event_instance1,
>> > TP_ARGS(
>> > int, my_integer_arg,
>> > struct app_struct *, app_struct_arg
>> > )
>> > )

>> > TRACEPOINT_EVENT_INSTANCE(
>> > my_provider,
>> > my_tracepoint_class,
>> > event_instance2,
>> > TP_ARGS(
>> > int, my_integer_arg,
>> > struct app_struct *, app_struct_arg
>> > )
>> > )


>> > _______________________________________________
>> > lttng-dev mailing list
>> > [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_8703ba5a-2c4a-4bdd-9d55-e6d8fe5bc3df
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>This is due to limitations of the C preproc=
essor. We need to have the TP_ARGS() available<br></div><div>both in the TR=
ACEPOINT_EVENT_INSTANCE(), which generates the tracepoint prototype<br data=
-mce-bogus=3D"1"></div><div>used to validate type compability of the tracep=
oint callsite within the application, and within<br data-mce-bogus=3D"1"></=
div><div>TRACEPOINT_EVENT_CLASS() which is used to generate the probe callb=
ack with the</div><div>correct arguments.<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div>Unfortunately, the C preprocessor doe=
s not allow much freedom when it comes to accessing<br></div><div>arguments=
 of another macro.<br data-mce-bogus=3D"1"></div><div><br></div><div>Thanks=
,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Ma=
thieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Dec 20, 2018, at =
12:21 PM, Yonghong Yan &lt;yanyh15@gmail.com&gt; wrote:<br></span></div><di=
v data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px soli=
d #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fo=
nt-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif=
;font-size:12pt;"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div>Then why bother=
 to require to have the TP_ARGS in TRACEPOINT_EVENT_INSTANCE?&nbsp;</div><b=
r><div>Yonghong</div><br></div></div></div></div><div class=3D"gmail_quote"=
><div dir=3D"ltr">On Thu, Dec 20, 2018 at 11:56 AM Philippe Proulx &lt;<a h=
ref=3D"mailto:eeppeliteloop@gmail.com" target=3D"_blank">eeppeliteloop@gmai=
l.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Thu, Dec 20, 2018 at 11:47 AM Yonghong Yan &lt;<a href=3D"mailto:ya=
nyh15@gmail.com" target=3D"_blank">yanyh15@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; I am looking at the following example from lttng-ust manual. The same =
TP_ARGS ( ... ) are repeated in both the TRACEPOINT_EVENT_CLASS and TRACEPO=
INT_EVENT_INSTANCE definition. My understanding is that it actually allows =
using different arguments, even in this example it is the same. Am I right?=
<br>
<br>
No it does not: they need to match.<br>
<br>
See &lt;<a href=3D"https://github.com/lttng/lttng-ust/commit/c75c0422c64f33=
c0102e1778cecc812c58b700e5" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/lttng/lttng-ust/commit/c75c0422c64f33c0102e1778cecc812c58b700e5</a=
>&gt;.<br>
<br>
Phil<br>
<br>
&gt;<br>
&gt; I also like the feature of having one TP_ARGS in the TRACEPOINT_EVENT_=
CLASS that declares the arguments for several TRACEPOINT_EVENT_INSTANCE so =
we do not need to have TP_ARGS in TRACEPOINT_EVENT_INSTANCE. Is that possib=
le?<br>
&gt;<br>
&gt; Thank you<br>
&gt; Yonghong<br>
&gt;<br>
&gt; TRACEPOINT_EVENT_CLASS(<br>
&gt;&nbsp; &nbsp; &nbsp;my_provider,<br>
&gt;&nbsp; &nbsp; &nbsp;my_tracepoint_class,<br>
&gt;&nbsp; &nbsp; &nbsp;TP_ARGS(<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int, my_integer_arg,<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct app_struct *, app_struct_arg<b=
r>
&gt;&nbsp; &nbsp; &nbsp;),<br>
&gt;&nbsp; &nbsp; &nbsp;TP_FIELDS(<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_integer(int, a, my_integer_arg)<b=
r>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_integer(unsigned long, b, app_str=
uct_arg-&gt;b)<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_string(c, app_struct_arg-&gt;c)<b=
r>
&gt;&nbsp; &nbsp; &nbsp;)<br>
&gt; )<br>
&gt;<br>
&gt; TRACEPOINT_EVENT_INSTANCE(<br>
&gt;&nbsp; &nbsp; &nbsp;my_provider,<br>
&gt;&nbsp; &nbsp; &nbsp;my_tracepoint_class,<br>
&gt;&nbsp; &nbsp; &nbsp;event_instance1,<br>
&gt;&nbsp; &nbsp; &nbsp;TP_ARGS(<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int, my_integer_arg,<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct app_struct *, app_struct_arg<b=
r>
&gt;&nbsp; &nbsp; &nbsp;)<br>
&gt; )<br>
&gt;<br>
&gt; TRACEPOINT_EVENT_INSTANCE(<br>
&gt;&nbsp; &nbsp; &nbsp;my_provider,<br>
&gt;&nbsp; &nbsp; &nbsp;my_tracepoint_class,<br>
&gt;&nbsp; &nbsp; &nbsp;event_instance2,<br>
&gt;&nbsp; &nbsp; &nbsp;TP_ARGS(<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int, my_integer_arg,<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct app_struct *, app_struct_arg<b=
r>
&gt;&nbsp; &nbsp; &nbsp;)<br>
&gt; )<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_8703ba5a-2c4a-4bdd-9d55-e6d8fe5bc3df--

--===============9185042519307266054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9185042519307266054==--
