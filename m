From: Klaus Dannecker <klaus.dannecker@gmx.de>
Subject: Re: make a trace_event in a modul (driver)
Date: Sun, 24 Nov 2013 19:26:05 +0100
Message-ID: <529244BD.7070407__44666.2773182199$1385317609$gmane$org@gmx.de>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5932@VAL-E-01.valcartier.drdc-rddc.gc.ca>	<5291E675.8070908@gmx.de>
	<CA+jJMxssu064JygayJ6KvcMb2AwbPsV5RHugtpO5ZZ9UsvcqOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.17.21])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <klaus.dannecker@gmx.de>) id 1VkeNF-0007wX-L4
	for lttng-dev@lists.lttng.org; Sun, 24 Nov 2013 13:25:43 -0500
Received: from [192.168.178.21] ([178.2.15.135]) by mail.gmx.com (mrgmx001)
	with ESMTPSA (Nemesis) id 0M936L-1Vx42o3TBd-00CSkq for
	<lttng-dev@lists.lttng.org>; Sun, 24 Nov 2013 19:25:32 +0100
In-Reply-To: <CA+jJMxssu064JygayJ6KvcMb2AwbPsV5RHugtpO5ZZ9UsvcqOw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Thibault,
	Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org


Am 24.11.2013 17:01, schrieb J=E9r=E9mie Galarneau:
> On Sun, Nov 24, 2013 at 6:43 AM, Klaus Dannecker <klaus.dannecker@gmx.de>=
 wrote:
>> Am 22.11.2013 19:54, schrieb Thibault, Daniel:
>>
>>>> how can I define a "tracing"group , so I no longer need the sudo comma=
nd?
>>> $ sudo addgroup --system tracing
>>> $ sudo adduser username tracing
>>>
>>> You must log off and back on for group membership to be activated.
>>>
>>> You may also want to add lttng-sessiond as a service:
>>>
>>> $ sudo ln --symbolic /lib/init/upstart-job /etc/init.d/lttng-sessiond
>>>
>>> And create /etc/init/lttng-sessiond.conf containing:
>>>
>>> description "LTTng central tracing registry session daemon"
>>> author "St=E9phane Graber <stgraber@ubuntu.com>"
>>> start on local-filesystems
>>> stop on runlevel [06]
>>> respawn
>>> exec lttng-sessiond
>>>
>>> You can then start the session daemon with 'sudo service lttng-sessiond
>>> start' (stop it with 'stop', restart with 'restart').
>> Thanks, now it works
>> but when i
>> $ lttng create
>> $ lttng enable-event -k -a
>> $ lttng start
>> so, the function does not return!
>> only 'strg c' terminated the fuktion.
>>
> Interesting. Would you mind running "lttng start" in verbose mode and
> provide the output?
> lttng -vvv start
klaus@ubuntu:~$ sudo lttng -vvv start
DEBUG2 [2854/2854]: Config file path found: /home/klaus (in =

get_session_name() at utils.c:57)
DEBUG1 [2854/2854]: Session name found: auto-20131124-091639 (in =

get_session_name() at utils.c:58)
DEBUG1 [2854/2854]: Starting tracing for session auto-20131124-091639 =

(in start_tracing() at commands/start.c:81)
DEBUG1 [2854/2854]: LSM cmd type : 16 (in send_session_msg() at =

lttng-ctl.c:131)
'ctrl c'
klaus@ubuntu:~$

>> the same by
>> $ lttng stop
>> and
>> $ lttng destroy
>>
>> but
>> $ lttng create
>> $ lttng enable-event -u -a
>> $ lttng start
>> $ lttng stop
>> $ lttng destroy
>> -> works
>>
>> how can i remove all installed lttng_modules,
>> so that I can start again from the beginning?
>>
> lttng-modules does not define an "uninstall" make target. I guess
> you'll have to delete the modules manually under
> /lib/modules/$(uname -r)/extra
> /lib/modules/$(uname -r)/extra/lib
> /lib/modules/$(uname -r)/extra/probes
>
> I'm wondering if it could be a conflict with your distribution's
> lttng-modules-dkms package... Could you verify that it is not
> installed?
now i make two experiments:
first:
install ubuntu 12.04 in vmware
$ git clone git://git.lttng.org/lttng-tools.git
$ git clone git://git.lttng.org/lttng-modules.git
$ git clone git://git.lttng.org/lttng-ust.git
$ git clone git://git.lttng.org/userspace-rcu.git
compile and install all like:
https://www.ibm.com/developerworks/community/blogs/fe313521-2e95-46f2-817d-=
44a4f27eba32/entry/howto_tracing_with_lttng?lang=3Den
now i have the same problem.

second:
install ubuntu 12.04 in vmware
sudo apt-get install lttng-tools
...
Building only for 3.8.0-29-generic
Building initial module for 3.8.0-29-generic
Error! Bad return status for module build on kernel: 3.8.0-29-generic (i686)
Consult /var/lib/dkms/lttng-modules/2.0.2/build/make.log for more =

information.
Setting up lttng-tools (2.0.1-0ubuntu1) ...
/usr/sbin/addgroup
lttng-sessiond start/running, process 5515
Processing triggers for libc-bin ...
ldconfig deferred processing now taking place
klaus@ubuntu:~$

$ git clone git://git.lttng.org/lttng-modules.git
compile and install lttng_moules

now works lttng start, stop and destroy!

Klaus
>> Thanks
>> Klaus
>> sorry, i am a linux beginner
> No problem, we all were at some point :)
>
> J=E9r=E9mie
>
>>
>>> Daniel U. Thibault
>>> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
>>> Countermeasures (SPC)
>>> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Criti=
cal
>>> Cyber Security (MCCS)
>>> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&D
>>> Canada - Valcartier (DRDC Valcartier)
>>> 2459 route de la Bravoure
>>> Qu=E9bec QC  G3J 1X5
>>> CANADA
>>> Vox : (418) 844-4000 x4245
>>> Fax : (418) 844-4538
>>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>>> Gouvernement du Canada | Government of Canada
>>> <http://www.valcartier.drdc-rddc.gc.ca/>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
