From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: lttng-modules addons stable (sort of)
Date: Wed, 26 Nov 2014 12:24:58 -0500
Message-ID: <CAC6yHM6L4GXbg8cSgJQ6gBioZk9mSRSqQsE22DkmdbSt1Bg3MQ__46542.8532836542$1417022748$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0507984399=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1XtgKt-00021R-VO
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 12:25:07 -0500
Received: by mail-qg0-f53.google.com with SMTP id q108so2394853qgd.12
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 09:24:58 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0507984399==
Content-Type: multipart/alternative; boundary=001a1133322a92a2ca0508c64e8c

--001a1133322a92a2ca0508c64e8c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

After the LinuxCon event, some people were interested to install the addons
for LTTng to perform active path analysis and virtual machine experiments.
I did a clean rebase on master (with a linear log), and kept only stable
features for this purpose.

* Record part of TCPv4 header using netfilter hook
  * inet_sock_local_in
  * inet_sock_local_out

* Wake-up signal between task (tracepoint before the wakeup IPI)
  * sched_ttwu

* KVM virtual machine synchronization
  * vmsync_gh_guest
  * vmsync_gh_host
  * vmsync_hg_guest
  * vmsync_hg_host

Features *removed* from the addons stable branch:
  * lttng_statedump_inet_sock: list of opened sockets at trace start
  * inet_sock_clone, inet_sock_create, inet_sock_delete: these were too
hackish (required to overload the IPv4 socket family and a couple of
kprobes)
  * syscall_entry (single event, with syscall id as the only field)
  * per-context callstack for user/kernel: unstable, requires more love
(along with mmap_exec_file event)

I would like to thanks the following contributors:
  * Mathieu Desnoyers: valuable advices and reviews
  * Mohamad Gebai: vmsync instrumentation
  * Genevi=C3=A8ve Bastien: testing, fixes and improvements
  * Fran=C3=A7ois Doray: porting instrumentation to newer macros

Further development will occur in addons-staging, to keep the addons branch
stable. If you find any issue with the addons, you can fill an issue on
github.

https://github.com/giraldeau/lttng-modules/tree/addons

Cheers,

Francis

--001a1133322a92a2ca0508c64e8c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">After the LinuxCon event, some people were interested to i=
nstall the addons for LTTng to perform active path analysis and virtual mac=
hine experiments. I did a clean rebase on master (with a linear log), and k=
ept only stable features for this purpose.=C2=A0<div><br></div><div>* Recor=
d part of TCPv4 header using netfilter hook</div><div>=C2=A0 * inet_sock_lo=
cal_in</div><div>=C2=A0 * inet_sock_local_out</div><div><br></div><div>* Wa=
ke-up signal between task (tracepoint before the wakeup IPI)</div><div>=C2=
=A0 * sched_ttwu</div><div><br></div><div>* KVM virtual machine synchroniza=
tion</div><div>=C2=A0 * vmsync_gh_guest</div><div>=C2=A0 * vmsync_gh_host<b=
r></div><div>=C2=A0 * vmsync_hg_guest<br></div><div>=C2=A0 * vmsync_hg_host=
<br></div><div><br></div><div>Features *removed* from the addons stable bra=
nch:=C2=A0</div><div>=C2=A0 * lttng_statedump_inet_sock: list of opened soc=
kets at trace start</div><div>=C2=A0 * inet_sock_clone, inet_sock_create, i=
net_sock_delete: these were too hackish (required to overload the IPv4 sock=
et family and a couple of kprobes)</div><div>=C2=A0 * syscall_entry (single=
 event, with syscall id as the only field)<br></div><div>=C2=A0 * per-conte=
xt callstack for user/kernel: unstable, requires more love (along with=C2=
=A0mmap_exec_file event)</div><div><br></div><div>I would like to thanks th=
e following contributors:=C2=A0</div><div>=C2=A0 * Mathieu Desnoyers: valua=
ble advices and reviews</div><div>=C2=A0 * Mohamad Gebai: vmsync instrument=
ation</div><div>=C2=A0 * Genevi=C3=A8ve Bastien: testing, fixes and improve=
ments</div><div>=C2=A0 * Fran=C3=A7ois Doray: porting instrumentation to ne=
wer macros</div><div><br></div><div>Further development will occur in addon=
s-staging, to keep the addons branch stable. If you find any issue with the=
 addons, you can fill an issue on github.=C2=A0</div><div><br></div><div><a=
 href=3D"https://github.com/giraldeau/lttng-modules/tree/addons">https://gi=
thub.com/giraldeau/lttng-modules/tree/addons</a><br></div><div><br></div><d=
iv>Cheers,</div><div><br></div><div>Francis</div></div>

--001a1133322a92a2ca0508c64e8c--


--===============0507984399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0507984399==--
