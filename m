From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re:
 =?utf-8?b?5Zue5aSNOlJlOiAgZG9jdW1lbnRhdGlvbiBhYm91?=
 =?utf-8?q?t_CTF_event_payload?=
Date: Tue, 26 Nov 2019 09:47:34 -0500 (EST)
Message-ID: <733360507.225.1574779654690.JavaMail.zimbra__40323.9760243864$1574779680$gmane$org@efficios.com>
References: <tencent_5F6B34D931D7AD241AA8EF79@qq.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8851017430349875235=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47MmwH4nDlz1R8T
 for <lttng-dev@lists.lttng.org>; Tue, 26 Nov 2019 09:47:43 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0F321423794
 for <lttng-dev@lists.lttng.org>; Tue, 26 Nov 2019 09:47:37 -0500 (EST)
In-Reply-To: <tencent_5F6B34D931D7AD241AA8EF79@qq.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?B?5p2o5rW3?= <hai.yang@magic-shield.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8851017430349875235==
Content-Type: multipart/alternative;
	boundary="=_3503cec7-a241-405f-a23c-a0665a3b2ad1"

--=_3503cec7-a241-405f-a23c-a0665a3b2ad1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

(adding back lttng-dev in CC for the benefit of others)=20

Whenever possible, we try to augment the trace data with such additional=20
information at post-processing, because capturing it at run-time repeatedly=
 ends=20
up being costly.=20

The lttng-analyses project contains state tracker which augment the trace d=
ata=20
with mapping from file descriptor to corresponding file names (see lttngana=
lyses/linuxautomaton/io.py).=20
I'm not sure if the Trace Compass project models this mapping between file =
descriptors and their=20
associated file, but if not, it would be an *extremely* useful addition.=20

lttng-modules already dumps the information needed to create that model:=20

- lttng_statedump_file_descriptor dumps all existing file descriptors for a=
ll processes,=20
- a few system calls (open, dup, dup2, dup3, close, clone(see CLONE_FILES f=
lag), fork,=20
fcntl(cmd=3D=3DF_DUPFD)) allow tracking the file descriptor table state cha=
nges during the trace.=20

Thanks,=20

Mathieu=20

----- On Nov 25, 2019, at 7:36 PM, =E6=9D=A8=E6=B5=B7 <hai.yang@magic-shiel=
d.com> wrote:=20

> Hi Mathieu

> Thanks for quick response. Here let me give an example. For syscalls open=
, LTTng
> output filename in entry_open and output fd as ret in exit_open. It would=
 be
> desired to output both filename and fd so we can correlate them.
> I am not sure whether there is a configuration that we can have the riche=
st
> output regarding to syscalls.
> If not, we can modify lttng-modules to output what we need. Or any other
> recommendation?

> Regards
> Hai

> ----------

> =E8=AF=A5=E9=82=AE=E4=BB=B6=E4=BB=8E=E7=A7=BB=E5=8A=A8=E8=AE=BE=E5=A4=87=
=E5=8F=91=E9=80=81

> --------------=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6--------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A"Mathieu Desnoyers "<mathieu.desnoyer=
s@efficios.com>;
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2019=E5=B9=B411=E6=9C=8820=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) =E6=99=9A=E4=B8=8A10:32
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"=E6=9D=A8=E6=B5=B7" <hai.yang@magic-=
shield.com>;
> =E6=8A=84=E9=80=81=EF=BC=9A"lttng-dev "<lttng-dev@lists.lttng.org>;
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: [lttng-dev] documentation about CTF event =
payload
> -----------------------------------
> For the system call payload documentation, you might want to refer to the=
 Linux
> system call
> man pages.

> For internal kernel tracepoints like sched_switch, there is no documentat=
ion of
> the meaning of
> each field at the moment. This state is the same as the upstream Linux ke=
rnel
> trace event. You'll
> have to figure it out on your own. Documenting each field of the ~500-100=
0 Linux
> kernel tracepoints
> is no small task.

> Thanks,

> Mathieu

> ----- On Nov 19, 2019, at 9:25 PM, =E6=9D=A8=E6=B5=B7 <hai.yang@magic-shi=
eld.com> wrote:

>> To be more specific, I suppose we can refer to
>> instrumentation\syscalls\3.10.0-rc7\x86-64-syscalls-3.10.0-rc7 for the p=
ayload
>> format of syscall event. Is it exactly in the CTF syscall event?

>> Regards
>> Hai
>> ------------------ Original ------------------
>> From: "=E6=9D=A8=E6=B5=B7"<hai.yang@magic-shield.com>;
>> Date: Mon, Nov 18, 2019 09:54 AM
>> To: "lttng-dev"<lttng-dev@lists.lttng.org>;
>> Subject: documentation about CTF event payload
>> Hi

>> As LTTng generated CTF and babeltrace parse it, we have the output as at=
tached.
>> We saw events such as sched_switch, but the payload cannot be understood
>> easily. Where we can find the document to explain the LTTng payload and
>> parameters?

>> Regards
>> Hai

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_3503cec7-a241-405f-a23c-a0665a3b2ad1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,<br></div><div><br data-mce-bogus=3D"1">=
</div><div>(adding back lttng-dev in CC for the benefit of others)<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Whenever pos=
sible, we try to augment the trace data with such additional<br data-mce-bo=
gus=3D"1"></div><div>information at post-processing, because capturing it a=
t run-time repeatedly ends</div><div>up being costly.<br data-mce-bogus=3D"=
1"></div><div><br data-mce-bogus=3D"1"></div><div>The lttng-analyses projec=
t contains state tracker which augment the trace data<br data-mce-bogus=3D"=
1"></div><div>with mapping from file descriptor to corresponding file names=
 (see lttnganalyses/linuxautomaton/io.py).</div><div>I'm not sure if the Tr=
ace Compass project models this mapping between file descriptors and their<=
br data-mce-bogus=3D"1"></div><div>associated file, but if not, it would be=
 an *extremely* useful addition.<br data-mce-bogus=3D"1"></div><div><br dat=
a-mce-bogus=3D"1"></div><div>lttng-modules already dumps the information ne=
eded to create that model:<br></div><div><br data-mce-bogus=3D"1"></div><di=
v>- lttng_statedump_file_descriptor dumps all existing file descriptors for=
 all processes,<br data-mce-bogus=3D"1"></div><div>- a few system calls (op=
en, dup, dup2, dup3, close, clone(see CLONE_FILES flag), fork,</div><div>fc=
ntl(cmd=3D=3DF_DUPFD)) allow tracking the file descriptor table state chang=
es during the trace.</div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<=
/div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"=
1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div><br></div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">--=
--- On Nov 25, 2019, at 7:36 PM, =E6=9D=A8=E6=B5=B7 &lt;hai.yang@magic-shie=
ld.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blo=
ckquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left=
:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div>Hi&nbsp;<span s=
tyle=3D"font-family:'arial' , 'helvetica' , sans-serif;font-size:16px">Math=
ieu</span></div><br><div>Thanks for quick response. Here let me give an exa=
mple. For syscalls open, LTTng output filename in entry_open and output fd =
as ret in exit_open. It would be desired to output both filename and fd so =
we can correlate them.&nbsp;</div><div>I am not sure whether there is a con=
figuration that we can have the richest output regarding to syscalls.&nbsp;=
</div><div>If not, we can modify lttng-modules to output what we need. Or a=
ny other recommendation?</div><br><div>Regards</div><div>Hai&nbsp;</div><di=
v><br>----------<br><p>=E8=AF=A5=E9=82=AE=E4=BB=B6=E4=BB=8E=E7=A7=BB=E5=8A=
=A8=E8=AE=BE=E5=A4=87=E5=8F=91=E9=80=81<br><br><br></p><br><br>------------=
--=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6--------------<br>=E5=8F=91=E4=BB=B6=
=E4=BA=BA=EF=BC=9A"Mathieu Desnoyers "&lt;mathieu.desnoyers@efficios.com&gt=
;;<br>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2019=E5=B9=B411=E6=9C=88=
20=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) =E6=99=9A=E4=B8=8A10:32<br>=E6=94=
=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"=E6=9D=A8=E6=B5=B7" &lt;hai.yang@magic-shiel=
d.com&gt;;<br>=E6=8A=84=E9=80=81=EF=BC=9A"lttng-dev "&lt;lttng-dev@lists.lt=
tng.org&gt;;<br>=E4=B8=BB=E9=A2=98=EF=BC=9ARe: [lttng-dev] documentation ab=
out CTF event payload<br>-----------------------------------<br></div> <div=
><div><div style=3D"font-family:'arial' , 'helvetica' , sans-serif;font-siz=
e:12pt;color:#000000"><div>For the system call payload documentation, you m=
ight want to refer to the Linux system call<br></div><div>man pages.<br></d=
iv><br><div>For internal kernel tracepoints like sched_switch, there is no =
documentation of the meaning of<br></div><div>each field at the moment. Thi=
s state is the same as the upstream Linux kernel trace event. You'll</div><=
div>have to figure it out on your own. Documenting each field of the ~500-1=
000 Linux kernel tracepoints</div><div>is no small task.<br></div><br><div>=
Thanks,<br></div><br><div>Mathieu<br></div><br><div><span id=3D"zwchr">----=
- On Nov 19, 2019, at 9:25 PM, =E6=9D=A8=E6=B5=B7 &lt;hai.yang@magic-shield=
.com&gt; wrote:<br></span></div><div><blockquote style=3D"border-left:2px s=
olid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:'helvetica' , 'arial' ,=
 sans-serif;font-size:12pt"><div>To be more specific, I suppose we can refe=
r to instrumentation\syscalls\3.10.0-rc7\x86-64-syscalls-3.10.0-rc7 for the=
 payload format of syscall event. Is it exactly in the CTF syscall event?</=
div><br><div>Regards</div><div>Hai</div><div><div>&nbsp;</div><div><div>---=
--------------- Original ------------------</div><div style=3D"font-size:12=
px;background:#efefef;padding:8px"><div><b>From: </b>&nbsp;"=E6=9D=A8=E6=B5=
=B7"&lt;hai.yang@magic-shield.com&gt;;</div><div><b>Date: </b>&nbsp;Mon, No=
v 18, 2019 09:54 AM</div><div><b>To: </b>&nbsp;"lttng-dev"&lt;lttng-dev@lis=
ts.lttng.org&gt;; </div><div><b>Subject: </b>&nbsp;documentation about CTF =
event payload</div></div><div>&nbsp;</div><div><div>Hi</div><br><div>As LTT=
ng generated CTF and babeltrace parse it, we have the output as attached. W=
e saw events such as sched_switch, but the payload cannot be understood eas=
ily. Where we can find the document to explain the LTTng payload and parame=
ters?</div><br><div>Regards</div><div>Hai</div></div></div></div><br>______=
_________________________________________<br>lttng-dev mailing list<br>lttn=
g-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev<br></blockquote></div><br><div>-- <br></div><div>Mathieu Desnoyers=
<br>EfficiOS Inc.<br>http://www.efficios.com</div></div>
</div></div><br></blockquote></div><div><br></div><div data-marker=3D"__SIG=
_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www=
.efficios.com</div></div></body></html>
--=_3503cec7-a241-405f-a23c-a0665a3b2ad1--

--===============8851017430349875235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8851017430349875235==--
