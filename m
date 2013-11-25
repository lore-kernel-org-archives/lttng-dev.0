From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: make a trace_event in a module (driver)
Date: Mon, 25 Nov 2013 15:53:04 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A5DA9__16428.0285513543$1385394942$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VkyTC-0006Io-9O
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 10:53:11 -0500
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

> Date: Sun, 24 Nov 2013 19:26:05 +0100
> From: Klaus Dannecker <klaus.dannecker@gmx.de>
>
> > Interesting. Would you mind running "lttng start" in verbose mode and =

> > provide the output?
> > lttng -vvv start
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

Definitely looks like a module loading problem.

> > lttng-modules does not define an "uninstall" make target. I guess =

> > you'll have to delete the modules manually under /lib/modules/$(uname =

> > -r)/extra /lib/modules/$(uname -r)/extra/lib /lib/modules/$(uname =

> > -r)/extra/probes
> >
> > I'm wondering if it could be a conflict with your distribution's =

> > lttng-modules-dkms package... Could you verify that it is not =

> > installed?
>
> now i make two experiments:
> first:
> install ubuntu 12.04 in vmware
> $ git clone git://git.lttng.org/lttng-tools.git
> $ git clone git://git.lttng.org/lttng-modules.git
> $ git clone git://git.lttng.org/lttng-ust.git
> $ git clone git://git.lttng.org/userspace-rcu.git
> compile and install all like:
> https://www.ibm.com/developerworks/community/blogs/fe313521-2e95-46f2-817=
d-44a4f27eba32/entry/howto_tracing_with_lttng?lang=3Den
> now i have the same problem.

   Aha!  There is one crucial mistake in the ibm.com document: he installs =
the packages in the wrong order.  lttng-tools must be installed AFTER lttng=
-modules and lttng-ust.  lttng-modules can be installed before, during or a=
fter lttng-ust, but userspace-rcu must be installed before lttng-ust.
   The problem is that the configure of lttng-tools detects the presence or=
 absence of lttng-modules and also detects the presence or absence of lttng=
-ust, and adjusts to both.  By installing lttng-tools before lttng-modules,=
 you've built an lttng-tools set that CANNOT be used to trace the kernel.

   So, try again from scratch, making sure to install lttng-tools last.

> second:
> install ubuntu 12.04 in vmware
> sudo apt-get install lttng-tools
>...
> Building only for 3.8.0-29-generic
> Building initial module for 3.8.0-29-generic
> Error! Bad return status for module build on kernel: 3.8.0-29-generic (i6=
86)
> Consult /var/lib/dkms/lttng-modules/2.0.2/build/make.log for more informa=
tion.
> Setting up lttng-tools (2.0.1-0ubuntu1) ...
> /usr/sbin/addgroup
> lttng-sessiond start/running, process 5515
> Processing triggers for libc-bin ...
> ldconfig deferred processing now taking place
> klaus@ubuntu:~$

   The Ubuntu lttng 2.0.1 install will very likely run into trouble against=
 kernel 3.8 because of the new module signing requirements.

> $ git clone git://git.lttng.org/lttng-modules.git
> compile and install lttng_modules
>
> now works lttng start, stop and destroy!
>
> Klaus

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
