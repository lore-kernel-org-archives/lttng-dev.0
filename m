From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: make a trace_event in a module (driver)
Date: Mon, 25 Nov 2013 12:00:14 -0500
Message-ID: <CA+jJMxvEq4P9ggVawhhgdyN9E=F8fy4QCZB1_+ncchswk2WBzQ__18438.5020439096$1385398880$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5DA9@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VkzWF-0001ym-Vh
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 12:00:26 -0500
Received: by mail-qe0-f45.google.com with SMTP id 6so4202854qea.18
	for <lttng-dev@lists.lttng.org>; Mon, 25 Nov 2013 09:00:14 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267A5DA9@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Nov 25, 2013 at 10:53 AM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>> Date: Sun, 24 Nov 2013 19:26:05 +0100
>> From: Klaus Dannecker <klaus.dannecker@gmx.de>
>>
>> > Interesting. Would you mind running "lttng start" in verbose mode and
>> > provide the output?
>> > lttng -vvv start
>> klaus@ubuntu:~$ sudo lttng -vvv start
>> DEBUG2 [2854/2854]: Config file path found: /home/klaus (in get_session_=
name() at utils.c:57)
>> DEBUG1 [2854/2854]: Session name found: auto-20131124-091639 (in get_ses=
sion_name() at utils.c:58)
>> DEBUG1 [2854/2854]: Starting tracing for session auto-20131124-091639 (i=
n start_tracing() at commands/start.c:81)
>> DEBUG1 [2854/2854]: LSM cmd type : 16 (in send_session_msg() at lttng-ct=
l.c:131)
>> 'ctrl c'
>> klaus@ubuntu:~$
>
> Definitely looks like a module loading problem.
>
>> > lttng-modules does not define an "uninstall" make target. I guess
>> > you'll have to delete the modules manually under /lib/modules/$(uname
>> > -r)/extra /lib/modules/$(uname -r)/extra/lib /lib/modules/$(uname
>> > -r)/extra/probes
>> >
>> > I'm wondering if it could be a conflict with your distribution's
>> > lttng-modules-dkms package... Could you verify that it is not
>> > installed?
>>
>> now i make two experiments:
>> first:
>> install ubuntu 12.04 in vmware
>> $ git clone git://git.lttng.org/lttng-tools.git
>> $ git clone git://git.lttng.org/lttng-modules.git
>> $ git clone git://git.lttng.org/lttng-ust.git
>> $ git clone git://git.lttng.org/userspace-rcu.git
>> compile and install all like:
>> https://www.ibm.com/developerworks/community/blogs/fe313521-2e95-46f2-81=
7d-44a4f27eba32/entry/howto_tracing_with_lttng?lang=3Den
>> now i have the same problem.
>
>    Aha!  There is one crucial mistake in the ibm.com document: he install=
s the packages in the wrong order.  lttng-tools must be installed AFTER ltt=
ng-modules and lttng-ust.  lttng-modules can be installed before, during or=
 after lttng-ust, but userspace-rcu must be installed before lttng-ust.
>    The problem is that the configure of lttng-tools detects the presence =
or absence of lttng-modules and also detects the presence or absence of ltt=
ng-ust, and adjusts to both.  By installing lttng-tools before lttng-module=
s, you've built an lttng-tools set that CANNOT be used to trace the kernel.
>
>    So, try again from scratch, making sure to install lttng-tools last.
>

lttng-tools checks for kernel modules at run time, not at configure
time. You can safely install lttng-modules after lttng-tools and still
use kernel tracing.

Regards,
J=E9r=E9mie

>> second:
>> install ubuntu 12.04 in vmware
>> sudo apt-get install lttng-tools
>>...
>> Building only for 3.8.0-29-generic
>> Building initial module for 3.8.0-29-generic
>> Error! Bad return status for module build on kernel: 3.8.0-29-generic (i=
686)
>> Consult /var/lib/dkms/lttng-modules/2.0.2/build/make.log for more inform=
ation.
>> Setting up lttng-tools (2.0.1-0ubuntu1) ...
>> /usr/sbin/addgroup
>> lttng-sessiond start/running, process 5515
>> Processing triggers for libc-bin ...
>> ldconfig deferred processing now taking place
>> klaus@ubuntu:~$
>
>    The Ubuntu lttng 2.0.1 install will very likely run into trouble again=
st kernel 3.8 because of the new module signing requirements.
>
>> $ git clone git://git.lttng.org/lttng-modules.git
>> compile and install lttng_modules
>>
>> now works lttng start, stop and destroy!
>>
>> Klaus
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
