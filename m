From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: make a trace_event in a module (driver)
Date: Mon, 25 Nov 2013 19:22:44 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A5E6B__34494.66817915$1385407434$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Vl1k5-0005Jv-Jn
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 14:22:51 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> Date: Mon, 25 Nov 2013 12:00:14 -0500
> From: J?r?mie Galarneau <jeremie.galarneau@efficios.com>

>>    Aha!  There is one crucial mistake in the ibm.com document: he instal=
ls the packages in the wrong order.  lttng-tools must be installed AFTER lt=
tng-modules and lttng-ust.  lttng-modules can be installed before, during o=
r after lttng-ust, but userspace-rcu must be installed before lttng-ust.
>>    The problem is that the configure of lttng-tools detects the presence=
 or absence of lttng-modules and also detects the presence or absence of lt=
tng-ust, and adjusts to both.  By installing lttng-tools before lttng-modul=
es, you've built an lttng-tools set that CANNOT be used to trace the kernel.
>>
>>    So, try again from scratch, making sure to install lttng-tools last.
>
> lttng-tools checks for kernel modules at run time, not at configure time.=
 You can safely install lttng-modules after lttng-tools and still use kerne=
l tracing.
>
> Regards,
> J=E9r=E9mie

   Dang, you're right.  The build of lttng-tools reacts to the presence or =
absence of lttng-ust, but is indifferent to the presence or absence of lttn=
g-modules.  (Only liblttng-ctl.a is different, probably some internal times=
tamps or some such)

> klaus@ubuntu:~$ sudo lttng -vvv start
> DEBUG2 [2854/2854]: Config file path found: /home/klaus (in get_session_n=
ame() at utils.c:57)
> DEBUG1 [2854/2854]: Session name found: auto-20131124-091639 (in get_sess=
ion_name() at utils.c:58)
> DEBUG1 [2854/2854]: Starting tracing for session auto-20131124-091639 (in=
 start_tracing() at commands/start.c:81)
> DEBUG1 [2854/2854]: LSM cmd type : 16 (in send_session_msg() at lttng-ctl=
.c:131)
> 'ctrl c'
> klaus@ubuntu:~$

   Let's try to identify the module responsible.  First, make sure lttng-se=
ssiond is NOT running.  Then, do this in one shell:

$ sudo -H lttng-sessiond -vvv

   It should fail after loading one of the modules.

   You can also try:

$ sudo -H lttng-sessiond -vvv --no-kernel

   In which case you should be able to do any lttng command except those in=
volving the kernel.  For example, 'lttng list -u'.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
