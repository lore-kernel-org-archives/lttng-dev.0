From: Devanjan Choudhury <devanjan.dev@gmail.com>
Subject: Can userspace RCU be used with shared memory?
Date: Sun, 15 Sep 2013 19:14:46 +0530
Message-ID: <CAD2ZD83X2hV0hqkN-ADsMJZch5B8wJwR4bwTxP=jYgPrRnTu=A__39529.9988602803$1379271109$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1502428214=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <devanjan.dev@gmail.com>) id 1VLCd9-0003Zu-Ox
	for lttng-dev@lists.lttng.org; Sun, 15 Sep 2013 09:44:56 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so5632825iec.2
	for <lttng-dev@lists.lttng.org>; Sun, 15 Sep 2013 06:44:46 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1502428214==
Content-Type: multipart/alternative; boundary=bcaec51824926c40c704e66c4a6d

--bcaec51824926c40c704e66c4a6d
Content-Type: text/plain; charset=ISO-8859-1

Hello Mathieu,

We are interested in using userspace rcu for one of our projects.
Our main requirement is that we have some hash tables stored in shared
memory which will be accessed by multiple reader processes. We have one
single writer process. Since our use case is more read intensive compared
to write, we have choosen to use RCU to synchronize the shared data.

Now, when our writer process updates some nodes(lets say delete some node)
in hash tables stored in shared memory, it must call synchronize_rcu(),
before it can actually free up the node. However, one note in the
discussion (
http://lists.lttng.org/pipermail/lttng-dev/2012-December/019295.html)
states that synchronize_rcu() (or call_rcu()) executing in the context of
one process will not see the RCU read-side locks of another process. If
this is the case, then how/when can the writer process delete the node
permanently. Should we need to consider doing garbage collection on our own?

Also, if I undertsand correctly, shyncronize_rcu() does the following
basically:

void synchronize_rcu(void) { int cpu; for_each_online_cpu(cpu) run_on(cpu);
}

So, when our writer process call synchronize_rcu(), it will basically be
made to run on all the CPUs. Shouldn't this be sufficient to ensure that
any other reader process which had started a read rcu critical section has
completed?


-- 
Regards,
Devanjan

--bcaec51824926c40c704e66c4a6d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Mathieu,<div><br></div><div>We are interested in usi=
ng userspace rcu for one of our projects.</div><div>Our main requirement is=
 that we have some hash tables stored in shared memory which will be access=
ed by multiple reader processes. We have one single writer process. Since o=
ur use case is more read intensive compared to write, we have choosen to us=
e RCU to synchronize the shared data.</div>
<div><br></div><div>Now, when our writer process updates some nodes(lets sa=
y delete some node) in hash tables stored in shared memory, it must call sy=
nchronize_rcu(), before it can actually free up the node. However, one note=
 in the discussion (<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2=
012-December/019295.html">http://lists.lttng.org/pipermail/lttng-dev/2012-D=
ecember/019295.html</a>) states that=A0<span style=3D"color:rgb(0,0,0);whit=
e-space:pre-wrap">synchronize_rcu() (or call_rcu()) </span><span style=3D"c=
olor:rgb(0,0,0);white-space:pre-wrap">  executing in the context of one pro=
cess will not see the RCU read-side </span><span style=3D"color:rgb(0,0,0);=
white-space:pre-wrap"> locks of another process. If this is the case, then =
how/when can the writer process delete the node permanently. Should we need=
 to consider doing garbage collection on our own?</span></div>
<div><span style=3D"color:rgb(0,0,0);white-space:pre-wrap"><br></span></div=
><div><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">Also, if I unde=
rtsand correctly, shyncronize_rcu() does the  following basically:</span></=
div>
<div><span style=3D"color:rgb(0,0,0);white-space:pre-wrap"><br></span></div=
><div><font color=3D"#000000"><span style=3D"white-space:pre-wrap">void syn=
chronize_rcu(void)
{
        int cpu;
        for_each_online_cpu(cpu)
                run_on(cpu);
}</span></font><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">
</span></div><div><font color=3D"#000000"><span style=3D"white-space:pre-wr=
ap"><br></span></font></div><div><font color=3D"#000000"><span style=3D"whi=
te-space:pre-wrap">So, when our writer process call synchronize_rcu(), it w=
ill basically be made to run on all the CPUs. Shouldn&#39;t this be suffici=
ent to ensure that any other reader process which had started a read rcu cr=
itical section has completed? </span></font></div>
<div><span style=3D"color:rgb(0,0,0);white-space:pre-wrap"><br></span></div=
><div><div><br></div>-- <br>Regards,<br>Devanjan
</div></div>

--bcaec51824926c40c704e66c4a6d--


--===============1502428214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1502428214==--
