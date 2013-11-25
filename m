From: Klaus Dannecker <klaus.dannecker@gmx.de>
Subject: Re: make a trace_event in a module (driver)
Date: Mon, 25 Nov 2013 19:14:48 +0100
Message-ID: <52939398.20807__43807.7697567225$1385403322$gmane$org@gmx.de>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5DA9@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxvEq4P9ggVawhhgdyN9E=F8fy4QCZB1_+ncchswk2WBzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.15.19])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <klaus.dannecker@gmx.de>) id 1Vl0fs-0000aS-Nl
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 13:14:28 -0500
Received: from [192.168.178.21] ([94.217.80.178]) by mail.gmx.com (mrgmx103)
	with ESMTPSA (Nemesis) id 0MXqV1-1W7Mzx2MwZ-00WmHz for
	<lttng-dev@lists.lttng.org>; Mon, 25 Nov 2013 19:14:14 +0100
In-Reply-To: <CA+jJMxvEq4P9ggVawhhgdyN9E=F8fy4QCZB1_+ncchswk2WBzQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>, "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Am 25.11.2013 18:00, schrieb J=E9r=E9mie Galarneau:
> On Mon, Nov 25, 2013 at 10:53 AM, Thibault, Daniel
> <Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>>> Date: Sun, 24 Nov 2013 19:26:05 +0100
>>> From: Klaus Dannecker <klaus.dannecker@gmx.de>
>>>
>>>> Interesting. Would you mind running "lttng start" in verbose mode and
>>>> provide the output?
>>>> lttng -vvv start
>>> klaus@ubuntu:~$ sudo lttng -vvv start
>>> DEBUG2 [2854/2854]: Config file path found: /home/klaus (in get_session=
_name() at utils.c:57)
>>> DEBUG1 [2854/2854]: Session name found: auto-20131124-091639 (in get_se=
ssion_name() at utils.c:58)
>>> DEBUG1 [2854/2854]: Starting tracing for session auto-20131124-091639 (=
in start_tracing() at commands/start.c:81)
>>> DEBUG1 [2854/2854]: LSM cmd type : 16 (in send_session_msg() at lttng-c=
tl.c:131)
>>> 'ctrl c'
>>> klaus@ubuntu:~$
>> Definitely looks like a module loading problem.
>>
>>>> lttng-modules does not define an "uninstall" make target. I guess
>>>> you'll have to delete the modules manually under /lib/modules/$(uname
>>>> -r)/extra /lib/modules/$(uname -r)/extra/lib /lib/modules/$(uname
>>>> -r)/extra/probes
>>>>
>>>> I'm wondering if it could be a conflict with your distribution's
>>>> lttng-modules-dkms package... Could you verify that it is not
>>>> installed?
>>> now i make two experiments:
>>> first:
>>> install ubuntu 12.04 in vmware
>>> $ git clone git://git.lttng.org/lttng-tools.git
>>> $ git clone git://git.lttng.org/lttng-modules.git
>>> $ git clone git://git.lttng.org/lttng-ust.git
>>> $ git clone git://git.lttng.org/userspace-rcu.git
>>> compile and install all like:
>>> https://www.ibm.com/developerworks/community/blogs/fe313521-2e95-46f2-8=
17d-44a4f27eba32/entry/howto_tracing_with_lttng?lang=3Den
>>> now i have the same problem.
>>     Aha!  There is one crucial mistake in the ibm.com document: he insta=
lls the packages in the wrong order.  lttng-tools must be installed AFTER l=
ttng-modules and lttng-ust.  lttng-modules can be installed before, during =
or after lttng-ust, but userspace-rcu must be installed before lttng-ust.
>>     The problem is that the configure of lttng-tools detects the presenc=
e or absence of lttng-modules and also detects the presence or absence of l=
ttng-ust, and adjusts to both.  By installing lttng-tools before lttng-modu=
les, you've built an lttng-tools set that CANNOT be used to trace the kerne=
l.
>>
>>     So, try again from scratch, making sure to install lttng-tools last.
>>
> lttng-tools checks for kernel modules at run time, not at configure
> time. You can safely install lttng-modules after lttng-tools and still
> use kernel tracing.
>
> Regards,
> J=E9r=E9mie
ok, but what can i do?

>>> second:
>>> install ubuntu 12.04 in vmware
>>> sudo apt-get install lttng-tools
>>> ...
>>> Building only for 3.8.0-29-generic
>>> Building initial module for 3.8.0-29-generic
>>> Error! Bad return status for module build on kernel: 3.8.0-29-generic (=
i686)
>>> Consult /var/lib/dkms/lttng-modules/2.0.2/build/make.log for more infor=
mation.
>>> Setting up lttng-tools (2.0.1-0ubuntu1) ...
>>> /usr/sbin/addgroup
>>> lttng-sessiond start/running, process 5515
>>> Processing triggers for libc-bin ...
>>> ldconfig deferred processing now taking place
>>> klaus@ubuntu:~$
>>     The Ubuntu lttng 2.0.1 install will very likely run into trouble aga=
inst kernel 3.8 because of the new module signing requirements.
how can i signing the module?

Regards,
Klaus

>>> $ git clone git://git.lttng.org/lttng-modules.git
>>> compile and install lttng_modules
>>>
>>> now works lttng start, stop and destroy!
>>>
>>> Klaus
>> Daniel U. Thibault
>> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & =
Countermeasures (SPC)
>> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critic=
al Cyber Security (MCCS)
>> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence =
R&D Canada - Valcartier (DRDC Valcartier)
>> 2459 route de la Bravoure
>> Qu=E9bec QC  G3J 1X5
>> CANADA
>> Vox : (418) 844-4000 x4245
>> Fax : (418) 844-4538
>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>> Gouvernement du Canada | Government of Canada
>> <http://www.valcartier.drdc-rddc.gc.ca/>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
