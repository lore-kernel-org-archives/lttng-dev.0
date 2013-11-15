From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: how does ust tracer map share lttng buffer
Date: Fri, 15 Nov 2013 17:06:15 +0000 (UTC)
Message-ID: <414012525.68357.1384535175855.JavaMail.zimbra__42290.9243534834$1384535249$gmane$org@efficios.com>
References: <tencent_4B722D17200DC9B17B45EFF3@qq.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1384151190=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VhMqY-0005he-T3
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 12:06:25 -0500
In-Reply-To: <tencent_4B722D17200DC9B17B45EFF3@qq.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?6I2J5pyo56eA?= <39017736@qq.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1384151190==
Content-Type: multipart/alternative;
	boundary="----=_Part_68356_903892029.1384535175854"

------=_Part_68356_903892029.1384535175854
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "=E8=8D=89=E6=9C=A8=E7=A7=80" <39017736@qq.com>
> To: "mathieu.desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Friday, November 15, 2013 11:37:11 AM
> Subject: how does ust tracer map share lttng buffer

> Hi,Mathieu

> After lttng sub-command enable-event is issued at first time, lttng-consu=
merd
> will be informed by lttng-sessiond to open and mmap share memory regions
> .Then lttng-sessiond get all shmfds from lttng-consumerd.But how does ust
> tracer map to these share memory regions?

> AFAIK,lttng-sessiond will call do_consumer_create_channel() ,then
> send_channel_uid_to_ust(). What's confused me is in
> send_channel_uid_to_ust(),lttng-sessiond dup() one shmfd , then
> ust_consumer_send_stream_to_ust() to ust tracer, then close the shmfd and
> loop all shmfds. So all duped fds are the same fd-number (say A)and send =
to
> ust tracer through
> ust_consumer_send_stream_to_ust()->ustctl_send_stream_to_ust()->ustctl_se=
nd_stream()->ustcomm_send_fds_unix_sock()(unix
> socket is $HOME/.lttng/lttng-ust-sock-5).Why does it send the same fds to
> ust tracer?
> At ust tracer side,it calls
> handle_message()->ustcomm_recv_stream_from_sessiond() and mmap every
> received fd to share memory region.However,every received fd is different
> from A.So I must miss something anywhere.How does ust tracer map share lt=
tng
> buffer?

In lttng-sessiond, we send file descriptors for each posix SHM associated t=
o every per-cpu buffer to the application over unix socket. So it's more or=
 less : receive FD from consumer, send FD over unix socket to UST, close FD=
 (we loop on this). Indeed, from a sessiond point of view, this will typica=
lly use the same FD number, but it's really associated with a different pos=
ix SHM each time. David can probably answer your question in more detail.=
=20

Thanks,=20

Mathieu=20

> PS:code is from lttng-2.3.0 .

> Thanks
> MuXiu.Cao

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_68356_903892029.1384535175854
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"=E8=8D=89=E6=9C=A8=E7=
=A7=80" &lt;39017736@qq.com&gt;<br><b>To: </b>"mathieu.desnoyers" &lt;mathi=
eu.desnoyers@efficios.com&gt;<br><b>Sent: </b>Friday, November 15, 2013 11:=
37:11 AM<br><b>Subject: </b>how does ust tracer map share lttng buffer<br><=
div><br></div><div>Hi,Mathieu</div><div><br></div><div>&nbsp; &nbsp;After l=
ttng sub-command enable-event is issued at first time, lttng-consumerd will=
 be informed by lttng-sessiond to open and mmap share memory regions .Then =
lttng-sessiond get all shmfds from lttng-consumerd.But how does ust tracer =
map to these share memory regions?</div><div><br></div><div>&nbsp; AFAIK,lt=
tng-sessiond will call&nbsp;
do_consumer_create_channel() &nbsp;,then&nbsp;send_channel_uid_to_ust().&nb=
sp;What's confused me is in&nbsp;send_channel_uid_to_ust(),lttng-sessiond d=
up() one shmfd , then ust_consumer_send_stream_to_ust() to ust tracer, then=
 close the shmfd and loop all shmfds. So all duped fds are the same fd-numb=
er (say A)and send to ust tracer through&nbsp;ust_consumer_send_stream_to_u=
st()-&gt;ustctl_send_stream_to_ust()-&gt;ustctl_send_stream()-&gt;ustcomm_s=
end_fds_unix_sock()(unix socket is $HOME/.lttng/lttng-ust-sock-5).Why does =
it send the same fds to ust tracer?</div><div>&nbsp; At ust tracer side,it =
calls&nbsp;handle_message()-&gt;ustcomm_recv_stream_from_sessiond() and mma=
p every received fd to share memory region.However,every received fd is dif=
ferent from A.So I must miss something anywhere.How does ust tracer map sha=
re lttng buffer?</div></blockquote><div><br></div><div>In lttng-sessiond, w=
e send file descriptors for each posix SHM associated to every per-cpu buff=
er to the application over unix socket. So it's more or less : receive FD f=
rom consumer, send FD over unix socket to UST, close FD (we loop on this). =
Indeed, from a sessiond point of view, this will typically use the same FD =
number, but it's really associated with a different posix SHM each time. Da=
vid can probably answer your question in more detail.<br></div><div><br></d=
iv><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></di=
v><div><br></div><blockquote style=3D"border-left:2px solid #1010FF;margin-=
left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"=
><div><br></div><div>PS:code is from lttng-2.3.0 .</div><div><br></div><div=
>Thanks</div><div>MuXiu.Cao</div><div><br></div></blockquote><div><br><br><=
/div><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu =
Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></spa=
n><br></div></div></body></html>
------=_Part_68356_903892029.1384535175854--


--===============1384151190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1384151190==--
