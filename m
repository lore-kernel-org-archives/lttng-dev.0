From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Installing LTTNG on beaglebone black or rasberry pi
Date: Fri, 18 Nov 2016 14:56:48 +0000 (UTC)
Message-ID: <787460036.7594.1479481008011.JavaMail.zimbra__35651.2596285485$1479480962$gmane$org@efficios.com>
References: <CAAuy2ATLED2dopcqdjF4+Xpy7wA+OLeTwOvYma+BRkWR9xPKRg@mail.gmail.com>
 <CAF4oYfGS5Vf5CrS3XVFxDQkdrs=wtoNCNw5qOpf_G6_TDBLBsg@mail.gmail.com>
 <CAAuy2AQmRSC4Zg59gALTstfL+gBRTLynfAv0u6vhmgu-TumNpw@mail.gmail.com>
 <d0ef0af1-4c57-34bc-7764-fcf86764773f@efficios.com>
 <CAAuy2AR_efNuciOO46HPiN+dvSOg6RWvpghptgp_QdBwYow80Q@mail.gmail.com>
 <27c01d2b-4b81-9f2c-b4ce-962f529d9c45@efficios.com>
 <CAAuy2ARaNDi5fAUMKEG=a4AcTes=WsDgiiXJxo-uird39+3BpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5175783118598197961=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tL1L42HZXzdjr
 for <lttng-dev@lists.lttng.org>; Fri, 18 Nov 2016 14:57:00 +0000 (UTC)
In-Reply-To: <CAAuy2ARaNDi5fAUMKEG=a4AcTes=WsDgiiXJxo-uird39+3BpQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Nwafor, Ebelechukwu" <ebelechukwu.nwafor@bison.howard.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5175783118598197961==
Content-Type: multipart/alternative;
	boundary="=_e524b7f0-f831-402e-97aa-00d0c9e826fa"

--=_e524b7f0-f831-402e-97aa-00d0c9e826fa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 18, 2016, at 8:09 AM, Nwafor, Ebelechukwu <ebelechukwu.nwafor@bison.howard.edu> wrote: 

> Hello Jonathan.

> I have tried every other thing on your last message. Attached is the output of
> the lttng-sessiond -vvv

Hi, 

An important line in your log is "Error: Could not get lock file /var/run/lttng/lttng-sessiond.lck, another instance is running.", 
which is pretty much self-explaining. 

Please refer to https://bugs.lttng.org/ "Bug reporting guidelines" to provide 
complete information on your issue. 

Thanks, 

Mathieu 

> Thanks.

> root@ebele-desktop:~# lttng-sessiond -vvv
> DEBUG1 - 20:29:17.718632 [8086/8086]: run_as signal handler set for SIGTERM and
> SIGINT (in set_worker_sighandlers() at runas.c:600)
> DEBUG1 - 20:29:17.719781 [8085/8085]: Health check time delta in seconds set to
> 20 (in health_init() at health.c:74)
> DEBUG1 - 20:29:17.720333 [8085/8085]: epoll set max size is 334459 (in
> compat_epoll_set_max_size() at compat-epoll.c:290)
> DEBUG3 - 20:29:17.720888 [8085/8085]: Creating LTTng run directory:
> /var/run/lttng (in create_lttng_rundir() at main.c:5156)
> DEBUG2 - 20:29:17.721063 [8085/8085]: Kernel consumer err path:
> /var/run/lttng/kconsumerd/error (in main() at main.c:5601)
> DEBUG2 - 20:29:17.721101 [8085/8085]: Kernel consumer cmd path:
> /var/run/lttng/kconsumerd/command (in main() at main.c:5603)
> Error: Could not get lock file /var/run/lttng/lttng-sessiond.lck, another
> instance is running.
> DEBUG1 - 20:29:17.721231 [8085/8085]: Cleanup sessiond (in sessiond_cleanup() at
> main.c:622)
> DEBUG1 - 20:29:17.721322 [8085/8085]: Removing sessiond and consumerd content of
> directory /var/run/lttng (in sessiond_cleanup() at main.c:641)
> DEBUG1 - 20:29:17.721360 [8085/8085]: Removing /var/run/lttng/lttng-sessiond.pid
> (in sessiond_cleanup() at main.c:647)
> DEBUG1 - 20:29:17.721417 [8085/8085]: Removing /var/run/lttng/agent.port (in
> sessiond_cleanup() at main.c:652)
> DEBUG1 - 20:29:17.721462 [8085/8085]: Removing /var/run/lttng/kconsumerd/error
> (in sessiond_cleanup() at main.c:659)
> DEBUG1 - 20:29:17.721510 [8085/8085]: Removing directory
> /var/run/lttng/kconsumerd (in sessiond_cleanup() at main.c:665)
> DEBUG1 - 20:29:17.721558 [8085/8085]: Removing
> /var/run/lttng/ustconsumerd32/error (in sessiond_cleanup() at main.c:672)
> DEBUG1 - 20:29:17.721602 [8085/8085]: Removing directory
> /var/run/lttng/ustconsumerd32 (in sessiond_cleanup() at main.c:678)
> DEBUG1 - 20:29:17.721647 [8085/8085]: Removing
> /var/run/lttng/ustconsumerd64/error (in sessiond_cleanup() at main.c:685)
> DEBUG1 - 20:29:17.721693 [8085/8085]: Removing directory
> /var/run/lttng/ustconsumerd64 (in sessiond_cleanup() at main.c:691)
> DEBUG1 - 20:29:17.721734 [8085/8085]: Cleaning up all sessions (in
> sessiond_cleanup() at main.c:694)
> DEBUG1 - 20:29:17.721765 [8085/8085]: Cleaning up all agent apps (in
> sessiond_cleanup() at main.c:711)
> DEBUG1 - 20:29:17.721796 [8085/8085]: Closing all UST sockets (in
> sessiond_cleanup() at main.c:714)
> DEBUG2 - 20:29:17.721825 [8085/8085]: UST app cleaning registered apps hash
> table (in ust_app_clean_list() at ust-app.c:3702)
> DEBUG3 - 20:29:17.721856 [8085/8085]: Buffer registry destroy all registry (in
> buffer_reg_destroy_registries() at buffer-registry.c:716)
> DEBUG2 - 20:29:17.721886 [8085/8085]: Closing kernel fd (in sessiond_cleanup()
> at main.c:719)
> DEBUG1 - 20:29:17.721914 [8085/8085]: Unloading kernel modules (in
> sessiond_cleanup() at main.c:726)
> DEBUG1 - 20:29:17.722118 [8085/8087]: [ht-thread] startup. (in
> thread_ht_cleanup() at ht-cleanup.c:37)
> DEBUG3 - 20:29:17.723951 [8085/8087]: [ht-thread] Polling. (in
> thread_ht_cleanup() at ht-cleanup.c:67)
> DEBUG1 - 20:29:17.736599 [8085/8085]: Modprobe removal successful
> lttng-kretprobes (in modprobe_remove_lttng() at modprobe.c:126)
> DEBUG1 - 20:29:17.750243 [8085/8085]: Modprobe removal successful lttng-kprobes
> (in modprobe_remove_lttng() at modprobe.c:126)
> DEBUG1 - 20:29:17.763239 [8085/8085]: Modprobe removal successful lttng-ftrace
> (in modprobe_remove_lttng() at modprobe.c:126)
> DEBUG1 - 20:29:17.778109 [8085/8085]: Modprobe removal successful lttng-types
> (in modprobe_remove_lttng() at modprobe.c:126)
> DEBUG1 - 20:29:17.793153 [8085/8085]: Modprobe removal successful
> lttng-ring-buffer-metadata-mmap-client (in modprobe_remove_lttng() at
> modprobe.c:126)
> DEBUG1 - 20:29:17.810951 [8085/8085]: Modprobe removal successful
> lttng-ring-buffer-client-mmap-overwrite (in modprobe_remove_lttng() at
> modprobe.c:126)
> DEBUG1 - 20:29:17.823876 [8085/8085]: Modprobe removal successful
> lttng-ring-buffer-client-mmap-discard (in modprobe_remove_lttng() at
> modprobe.c:126)
> DEBUG1 - 20:29:17.836698 [8085/8085]: Modprobe removal successful
> lttng-ring-buffer-metadata-client (in modprobe_remove_lttng() at
> modprobe.c:126)
> DEBUG1 - 20:29:17.849417 [8085/8085]: Modprobe removal successful
> lttng-ring-buffer-client-overwrite (in modprobe_remove_lttng() at
> modprobe.c:126)
> DEBUG1 - 20:29:17.864495 [8085/8085]: Modprobe removal successful
> lttng-ring-buffer-client-discard (in modprobe_remove_lttng() at modprobe.c:126)
> DEBUG1 - 20:29:17.879363 [8085/8085]: Modprobe removal successful
> lttng-lib-ring-buffer (in modprobe_remove_lttng() at modprobe.c:126)
> DEBUG1 - 20:29:17.896710 [8085/8085]: Modprobe removal successful lttng-tracer
> (in modprobe_remove_lttng() at modprobe.c:126)
> DEBUG3 - 20:29:17.897048 [8085/8087]: [ht-thread] Returning from poll on 2 fds.
> (in thread_ht_cleanup() at ht-cleanup.c:74)
> DEBUG1 - 20:29:17.897154 [8085/8087]: [ht-cleanup] quit. (in thread_ht_cleanup()
> at ht-cleanup.c:153)
> DEBUG1 - 20:29:17.897262 [8085/8087]: [ht-cleanup] Thread terminates. (in
> thread_ht_cleanup() at ht-cleanup.c:164)
> DEBUG1 - 20:29:17.897743 [8085/8085]: Cleaning up options (in
> sessiond_cleanup_options() at main.c:773)
> DEBUG1 - 20:29:17.901442 [8085/8085]: lttng-runas terminated with status code 0
> (in run_as_destroy_worker() at runas.c:737)
> DEBUG1 - 20:29:17.901548 [8085/8085]: *** assert failed :-) *** ==> Matthew,
> BEET driven development works! (in sessiond_cleanup_options() at main.c:805)
> root@ebele-desktop:~#

> On Thu, Nov 17, 2016 at 7:38 PM, Jonathan Rajotte Julien < [
> mailto:Jonathan.rajotte-julien@efficios.com |
> Jonathan.rajotte-julien@efficios.com ] > wrote:

>> Hi,

>> On 2016-11-17 07:24 PM, Nwafor, Ebelechukwu wrote:

>>> Thanks Jonathan for you helpful response. I was able to install the specific
>>> linux-headers and it seems to install all of the modules. Now i've hit another
>>> roadblock. whenever i try to list all of the kernel events using lttng list -k,
>>> it throws an error: unable to list kernel events: Kernel tracer is not
>>> available. I have two lttng-sessiond running.

>> Terminate both of them. Since you installed it from apt-get the lttng-tools
>> package provide a service for lttng-sessiond implying that the lttng-sessiond
>> process should get restarted automatically if killed.

>> Again, make sure that the user issuing the "lttng list -k" is part of the
>> "tracing" group or simply root.

>> If this still does not work refer to the last email and stop the service then,
>> as root, launch "lttng-sessiond -vvv" and check the output to make sure that
>> the modules gets loaded.

>> Open another terminal and test the kernel tracepoint listing.

>> If this does not work make sure to include the output from "lttng-sessiond -vvv"
>> in your next email.

>> Cheers

>>> On Thu, Nov 17, 2016 at 4:45 PM, Jonathan Rajotte Julien < [
>>> mailto:Jonathan.rajotte-julien@efficios.com |
>>> Jonathan.rajotte-julien@efficios.com ] <mailto: [
>>> mailto:Jonathan.rajotte-julien@efficios.com |
>>> Jonathan.rajotte-julien@efficios.com ] >> wrote:

>>> Hi,

>>> On 2016-11-17 04:24 PM, Nwafor, Ebelechukwu wrote:

>>> Hi Jonathan. Thank you for your response.

>>> On the beaglebone black, i tried building lttng-tools,
>>> lttng-modules-dkms and lttng-ust-dev from source v2.8.1 by
>>> following the documentation. lttng-modules-dkms runs fine but
>>> the module does not show up on the list of running modules
>>> when i issue an lsmod command. Also, i run into errors while
>>> trying to build and compile lttng-tools. Beaglebone black runs
>>> on debian. Linux beaglebone 3.8.13-bone70 #1 SMP Fri Jan 23
>>> 02:15:42 UTC 2015 armv7l GNU/Linux

>>> What errors do you see when building lttng-tools?

>>> On the raspberry pi, I use the commands, apt-get install
>>> lttng-modules-dkms lttng-tools lttng-ust-dev. Everything seems
>>> to work fine with the exception of lttng-modules-dkms which
>>> does not show up on the list on running modules. Also, every
>>> time i try to view available kernel events, it comes up with
>>> an error saying unable to list kernel events: kernel tracer
>>> not available. The LTTNG version installed using apt-get is
>>> 2.7.1. I am running ubuntu mate OS. Below are the output while
>>> installing lttng-modules-dkms

>>> Well as the error points out do you have the kernel tracer started?

>>> ps -aux | grep lttng-sessiond

>>> Does the user trying to use lttng is part of the tracing group or
>>> is root ?

>>> You can start lttng-sessiond with the -vvv options make sure to be
>>> root when doing so lttng-sessiond load the tracing modules.

>>> Since you installed it from apt-get the lttng-tools package
>>> provide a daemon for lttng-sessiond so before testing manually:

>>> service lttng-sessiond stop

>>> root@ebele-desktop:~# apt-get install lttng-modules-dkms
>>> Reading package lists... Done
>>> Building dependency tree
>>> Reading state information... Done
>>> lttng-modules-dkms is already the newest version (2.7.1-1).
>>> 0 upgraded, 0 newly installed, 0 to remove and 14 not upgraded.
>>> 2 not fully installed or removed.
>>> After this operation, 0 B of additional disk space will be used.
>>> Do you want to continue? [Y/n] Y
>>> Setting up linux-headers-4.4.0-22 (4.4.0-22.40) ...
>>> Setting up lttng-modules-dkms (2.7.1-1) ...
>>> Loading new lttng-modules-2.7.1 DKMS files...
>>> First Installation: checking all kernels...
>>> dpkg: warning: version '*-*' has bad syntax: version number
>>> does not start with digit
>>> It is likely that 4.4.30-v7+ belongs to a chroot's host
>>> Module build for the currently running kernel was skipped
>>> since the
>>> kernel source for this kernel does not seem to be installed.

>>> Could you make sure that your linux header for the running kernel
>>> are installed.

>>> 4.4.30-v7+ seems like a custom kernel install.

>>> root@ebele-desktop:~#

>>> On Thu, Nov 17, 2016 at 3:00 PM, Jonathan Rajotte
>>> < [ mailto:jonathan.r.julien@gmail.com | jonathan.r.julien@gmail.com ]
>>> <mailto: [ mailto:jonathan.r.julien@gmail.com | jonathan.r.julien@gmail.com ] >
>>> <mailto: [ mailto:jonathan.r.julien@gmail.com | jonathan.r.julien@gmail.com ]
>>> <mailto: [ mailto:jonathan.r.julien@gmail.com | jonathan.r.julien@gmail.com ]
>>> >>> wrote:

>>> Hi,

>>> Could you be a bit more precise regarding which part of the
>>> documentation does not work ?

>>> How did you install it ? Distribution packages ? From
>>> sources ?
>>> Cross compiled ?

>>> What is your setup ? Raspian for the Pi ? Custom kernel
>>> image ?

>>> Cheers

>>> On Thu, Nov 17, 2016 at 2:54 PM, Nwafor, Ebelechukwu
>>> < [ mailto:ebelechukwu.nwafor@bison.howard.edu |
>>> ebelechukwu.nwafor@bison.howard.edu ]
>>> <mailto: [ mailto:ebelechukwu.nwafor@bison.howard.edu |
>>> ebelechukwu.nwafor@bison.howard.edu ] >
>>> <mailto: [ mailto:ebelechukwu.nwafor@bison.howard.edu |
>>> ebelechukwu.nwafor@bison.howard.edu ]
>>> <mailto: [ mailto:ebelechukwu.nwafor@bison.howard.edu |
>>> ebelechukwu.nwafor@bison.howard.edu ] >>> wrote:

>>> Hello.

>>> I am trying to install LTTNG tracing tool on raspberry
>>> pi and
>>> beaglebone black board.The official LTTNG
>>> documentation does
>>> not work on these devices. Does anyone know of any
>>> tutorial
>>> that can help me accomplish this? Thanks.

>>> -- Ebelechukwu Nwafor,
>>> Graduate Student,
>>> Howard University.

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ] <mailto: [
>>> mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ] >
>>> <mailto: [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> <mailto: [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ] >>
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
>>> < [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ] >
>>> < [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
>>> < [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ] >>

>>> -- Jonathan Rajotte Julien

>>> -- Ebelechukwu Nwafor,
>>> Graduate Student,
>>> Howard University.

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ] <mailto: [
>>> mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ] >
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
>>> < [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ] >

>>> -- Jonathan R. Julien
>>> Efficios

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ] <mailto: [
>>> mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ] >
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
>>> < [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ] >

>>> --
>>> Ebelechukwu Nwafor,
>>> Graduate Student,
>>> Howard University.

>> --
>> Jonathan R. Julien
>> Efficios

> --
> Ebelechukwu Nwafor,
> Graduate Student,
> Howard University.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_e524b7f0-f831-402e-97aa-00d0c9e826fa
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Nov 18, 2016, at 8:09 AM, Nwafor, Ebe=
lechukwu &lt;ebelechukwu.nwafor@bison.howard.edu&gt; wrote:<br></span><div =
data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt;"><div dir=3D"ltr"><div>Hello Jonathan.</div><br><div>I have =
tried every other thing on your last message. Attached is the output of the=
 lttng-sessiond -vvv</div></div></blockquote><div><br></div><div>Hi,<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>An importa=
nt line in your log is "Error: Could not get lock file /var/run/lttng/lttng=
-sessiond.lck, another instance is running.",<br data-mce-bogus=3D"1"></div=
><div>which is pretty much self-explaining.<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>Please refer to https://bugs.lttng.=
org/ "Bug reporting guidelines" to provide<br data-mce-bogus=3D"1"></div><d=
iv>complete information on your issue.<br data-mce-bogus=3D"1"></div><div><=
br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></di=
v><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px =
solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt;"><div dir=3D"ltr"><br><br><div>Thanks.</div><br><br>ro=
ot@ebele-desktop:~# lttng-sessiond -vvv<br>DEBUG1 - 20:29:17.718632 [8086/8=
086]: run_as signal handler set for SIGTERM and SIGINT (in set_worker_sigha=
ndlers() at runas.c:600)<br>DEBUG1 - 20:29:17.719781 [8085/8085]: Health ch=
eck time delta in seconds set to 20 (in health_init() at health.c:74)<br>DE=
BUG1 - 20:29:17.720333 [8085/8085]: epoll set max size is 334459 (in compat=
_epoll_set_max_size() at compat-epoll.c:290)<br>DEBUG3 - 20:29:17.720888 [8=
085/8085]: Creating LTTng run directory: /var/run/lttng (in create_lttng_ru=
ndir() at main.c:5156)<br>DEBUG2 - 20:29:17.721063 [8085/8085]: Kernel cons=
umer err path: /var/run/lttng/kconsumerd/error (in main() at main.c:5601)<b=
r>DEBUG2 - 20:29:17.721101 [8085/8085]: Kernel consumer cmd path: /var/run/=
lttng/kconsumerd/command (in main() at main.c:5603)<br>Error: Could not get=
 lock file /var/run/lttng/lttng-sessiond.lck, another instance is running.<=
br>DEBUG1 - 20:29:17.721231 [8085/8085]: Cleanup sessiond (in sessiond_clea=
nup() at main.c:622)<br>DEBUG1 - 20:29:17.721322 [8085/8085]: Removing sess=
iond and consumerd content of directory /var/run/lttng (in sessiond_cleanup=
() at main.c:641)<br>DEBUG1 - 20:29:17.721360 [8085/8085]: Removing /var/ru=
n/lttng/lttng-sessiond.pid (in sessiond_cleanup() at main.c:647)<br>DEBUG1 =
- 20:29:17.721417 [8085/8085]: Removing /var/run/lttng/agent.port (in sessi=
ond_cleanup() at main.c:652)<br>DEBUG1 - 20:29:17.721462 [8085/8085]: Remov=
ing /var/run/lttng/kconsumerd/error (in sessiond_cleanup() at main.c:659)<b=
r>DEBUG1 - 20:29:17.721510 [8085/8085]: Removing directory /var/run/lttng/k=
consumerd (in sessiond_cleanup() at main.c:665)<br>DEBUG1 - 20:29:17.721558=
 [8085/8085]: Removing /var/run/lttng/ustconsumerd32/error (in sessiond_cle=
anup() at main.c:672)<br>DEBUG1 - 20:29:17.721602 [8085/8085]: Removing dir=
ectory /var/run/lttng/ustconsumerd32 (in sessiond_cleanup() at main.c:678)<=
br>DEBUG1 - 20:29:17.721647 [8085/8085]: Removing /var/run/lttng/ustconsume=
rd64/error (in sessiond_cleanup() at main.c:685)<br>DEBUG1 - 20:29:17.72169=
3 [8085/8085]: Removing directory /var/run/lttng/ustconsumerd64 (in session=
d_cleanup() at main.c:691)<br>DEBUG1 - 20:29:17.721734 [8085/8085]: Cleanin=
g up all sessions (in sessiond_cleanup() at main.c:694)<br>DEBUG1 - 20:29:1=
7.721765 [8085/8085]: Cleaning up all agent apps (in sessiond_cleanup() at =
main.c:711)<br>DEBUG1 - 20:29:17.721796 [8085/8085]: Closing all UST socket=
s (in sessiond_cleanup() at main.c:714)<br>DEBUG2 - 20:29:17.721825 [8085/8=
085]: UST app cleaning registered apps hash table (in ust_app_clean_list() =
at ust-app.c:3702)<br>DEBUG3 - 20:29:17.721856 [8085/8085]: Buffer registry=
 destroy all registry (in buffer_reg_destroy_registries() at buffer-registr=
y.c:716)<br>DEBUG2 - 20:29:17.721886 [8085/8085]: Closing kernel fd (in ses=
siond_cleanup() at main.c:719)<br>DEBUG1 - 20:29:17.721914 [8085/8085]: Unl=
oading kernel modules (in sessiond_cleanup() at main.c:726)<br>DEBUG1 - 20:=
29:17.722118 [8085/8087]: [ht-thread] startup. (in thread_ht_cleanup() at h=
t-cleanup.c:37)<br>DEBUG3 - 20:29:17.723951 [8085/8087]: [ht-thread] Pollin=
g. (in thread_ht_cleanup() at ht-cleanup.c:67)<br>DEBUG1 - 20:29:17.736599 =
[8085/8085]: Modprobe removal successful lttng-kretprobes (in modprobe_remo=
ve_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:17.750243 [8085/8085]: Modp=
robe removal successful lttng-kprobes (in modprobe_remove_lttng() at modpro=
be.c:126)<br>DEBUG1 - 20:29:17.763239 [8085/8085]: Modprobe removal success=
ful lttng-ftrace (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 -=
 20:29:17.778109 [8085/8085]: Modprobe removal successful lttng-types (in m=
odprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:17.793153 [8085=
/8085]: Modprobe removal successful lttng-ring-buffer-metadata-mmap-client =
(in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:17.810951 =
[8085/8085]: Modprobe removal successful lttng-ring-buffer-client-mmap-over=
write (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:17.8=
23876 [8085/8085]: Modprobe removal successful lttng-ring-buffer-client-mma=
p-discard (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:=
17.836698 [8085/8085]: Modprobe removal successful lttng-ring-buffer-metada=
ta-client (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:=
17.849417 [8085/8085]: Modprobe removal successful lttng-ring-buffer-client=
-overwrite (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29=
:17.864495 [8085/8085]: Modprobe removal successful lttng-ring-buffer-clien=
t-discard (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:=
17.879363 [8085/8085]: Modprobe removal successful lttng-lib-ring-buffer (i=
n modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:17.896710 [8=
085/8085]: Modprobe removal successful lttng-tracer (in modprobe_remove_ltt=
ng() at modprobe.c:126)<br>DEBUG3 - 20:29:17.897048 [8085/8087]: [ht-thread=
] Returning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:74)=
<br>DEBUG1 - 20:29:17.897154 [8085/8087]: [ht-cleanup] quit. (in thread_ht_=
cleanup() at ht-cleanup.c:153)<br>DEBUG1 - 20:29:17.897262 [8085/8087]: [ht=
-cleanup] Thread terminates. (in thread_ht_cleanup() at ht-cleanup.c:164)<b=
r>DEBUG1 - 20:29:17.897743 [8085/8085]: Cleaning up options (in sessiond_cl=
eanup_options() at main.c:773)<br>DEBUG1 - 20:29:17.901442 [8085/8085]: ltt=
ng-runas terminated with status code 0 (in run_as_destroy_worker() at runas=
.c:737)<br>DEBUG1 - 20:29:17.901548 [8085/8085]: *** assert failed :-) *** =
=3D=3D&gt; Matthew, BEET driven development works! (in sessiond_cleanup_opt=
ions() at main.c:805)<br>root@ebele-desktop:~#&nbsp;<br></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Nov 17, 2016 at 7:38 P=
M, Jonathan Rajotte Julien <span dir=3D"ltr">&lt;<a href=3D"mailto:Jonathan=
.rajotte-julien@efficios.com" target=3D"_blank">Jonathan.rajotte-julien@eff=
icios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<span=
 class=3D""><br>
<br>
On 2016-11-17 07:24 PM, Nwafor, Ebelechukwu wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Thanks Jonathan for you helpful response. I was able to install the specifi=
c linux-headers and it seems to install all of the modules. Now i've hit an=
other roadblock. whenever i try to list all of the kernel events using lttn=
g list -k, it throws an error: unable to list kernel events: Kernel tracer =
is not available. I have two lttng-sessiond running.<br></blockquote>
<br></span>
Terminate both of them. Since you installed it from apt-get the lttng-tools=
 package provide a service for lttng-sessiond implying that the lttng-sessi=
ond process should get restarted automatically if killed.<br><br>
Again, make sure that the user issuing the "lttng list -k" is part of the "=
tracing" group or simply root.<br><br>
If this still does not work refer to the last email and stop the service th=
en, as root, launch "lttng-sessiond -vvv" and check the output to make sure=
 that the modules gets loaded.<br><br>
Open another terminal and test the kernel tracepoint listing.<br><br>
If this does not work make sure to include the output from "lttng-sessiond =
-vvv" in your next email.<br><br>
Cheers<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5"><br>
On Thu, Nov 17, 2016 at 4:45 PM, Jonathan Rajotte Julien &lt;<a href=3D"mai=
lto:Jonathan.rajotte-julien@efficios.com" target=3D"_blank">Jonathan.rajott=
e-julien@efficios.com</a> &lt;mailto:<a href=3D"mailto:Jonathan.rajotte-jul=
ien@efficios.com" target=3D"_blank">Jonathan.rajotte-julien@efficios.com</a=
>&gt;&gt; wrote:<br><br>
&nbsp; &nbsp; Hi,<br><br><br>
&nbsp; &nbsp; On 2016-11-17 04:24 PM, Nwafor, Ebelechukwu wrote:<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; Hi Jonathan. Thank you for your response.<br><b=
r>
&nbsp; &nbsp; &nbsp; &nbsp; On the beaglebone black, i tried building lttng=
-tools,<br>
&nbsp; &nbsp; &nbsp; &nbsp; lttng-modules-dkms and lttng-ust-dev from sourc=
e v2.8.1 by<br>
&nbsp; &nbsp; &nbsp; &nbsp; following the documentation. lttng-modules-dkms=
 runs fine but<br>
&nbsp; &nbsp; &nbsp; &nbsp; the module does not show up on the list of runn=
ing modules<br>
&nbsp; &nbsp; &nbsp; &nbsp; when i issue an lsmod command. Also, i run into=
 errors while<br>
&nbsp; &nbsp; &nbsp; &nbsp; trying to build and compile lttng-tools. Beagle=
bone black runs<br>
&nbsp; &nbsp; &nbsp; &nbsp; on debian. Linux beaglebone 3.8.13-bone70 #1 SM=
P Fri Jan 23<br>
&nbsp; &nbsp; &nbsp; &nbsp; 02:15:42 UTC 2015 armv7l GNU/Linux<br><br><br>
&nbsp; &nbsp; What errors do you see when building lttng-tools?<br><br><br>=
<br>
&nbsp; &nbsp; &nbsp; &nbsp; On the raspberry pi, I use the commands, apt-ge=
t install<br>
&nbsp; &nbsp; &nbsp; &nbsp; lttng-modules-dkms lttng-tools lttng-ust-dev. E=
verything seems<br>
&nbsp; &nbsp; &nbsp; &nbsp; to work fine with the exception of lttng-module=
s-dkms which<br>
&nbsp; &nbsp; &nbsp; &nbsp; does not show up on the list on running modules=
. Also, every<br>
&nbsp; &nbsp; &nbsp; &nbsp; time i try to view available kernel events, it =
comes up with<br>
&nbsp; &nbsp; &nbsp; &nbsp; an error saying unable to list kernel events: k=
ernel tracer<br>
&nbsp; &nbsp; &nbsp; &nbsp; not available. The LTTNG version installed usin=
g apt-get is<br>
&nbsp; &nbsp; &nbsp; &nbsp; 2.7.1. I am running ubuntu mate OS. Below are t=
he output while<br>
&nbsp; &nbsp; &nbsp; &nbsp; installing lttng-modules-dkms<br><br><br>
&nbsp; &nbsp; Well as the error points out do you have the kernel tracer st=
arted?<br><br>
&nbsp; &nbsp; ps -aux | grep lttng-sessiond<br><br>
&nbsp; &nbsp; Does the user trying to use lttng is part of the tracing grou=
p or<br>
&nbsp; &nbsp; is root ?<br><br>
&nbsp; &nbsp; You can start lttng-sessiond with the -vvv options make sure =
to be<br>
&nbsp; &nbsp; root when doing so lttng-sessiond load the tracing modules.<b=
r><br>
&nbsp; &nbsp; Since you installed it from apt-get the lttng-tools package<b=
r>
&nbsp; &nbsp; provide a daemon for lttng-sessiond so before testing manuall=
y:<br><br>
&nbsp; &nbsp; service lttng-sessiond stop<br><br><br><br>
&nbsp; &nbsp; &nbsp; &nbsp; root@ebele-desktop:~# apt-get install lttng-mod=
ules-dkms<br>
&nbsp; &nbsp; &nbsp; &nbsp; Reading package lists... Done<br>
&nbsp; &nbsp; &nbsp; &nbsp; Building dependency tree<br>
&nbsp; &nbsp; &nbsp; &nbsp; Reading state information... Done<br>
&nbsp; &nbsp; &nbsp; &nbsp; lttng-modules-dkms is already the newest versio=
n (2.7.1-1).<br>
&nbsp; &nbsp; &nbsp; &nbsp; 0 upgraded, 0 newly installed, 0 to remove and =
14 not upgraded.<br>
&nbsp; &nbsp; &nbsp; &nbsp; 2 not fully installed or removed.<br>
&nbsp; &nbsp; &nbsp; &nbsp; After this operation, 0 B of additional disk sp=
ace will be used.<br>
&nbsp; &nbsp; &nbsp; &nbsp; Do you want to continue? [Y/n] Y<br>
&nbsp; &nbsp; &nbsp; &nbsp; Setting up linux-headers-4.4.0-22 (4.4.0-22.40)=
 ...<br>
&nbsp; &nbsp; &nbsp; &nbsp; Setting up lttng-modules-dkms (2.7.1-1) ...<br>
&nbsp; &nbsp; &nbsp; &nbsp; Loading new lttng-modules-2.7.1 DKMS files...<b=
r>
&nbsp; &nbsp; &nbsp; &nbsp; First Installation: checking all kernels...<br>
&nbsp; &nbsp; &nbsp; &nbsp; dpkg: warning: version '*-*' has bad syntax: ve=
rsion number<br>
&nbsp; &nbsp; &nbsp; &nbsp; does not start with digit<br>
&nbsp; &nbsp; &nbsp; &nbsp; It is likely that 4.4.30-v7+ belongs to a chroo=
t's host<br>
&nbsp; &nbsp; &nbsp; &nbsp; Module build for the currently running kernel w=
as skipped<br>
&nbsp; &nbsp; &nbsp; &nbsp; since the<br>
&nbsp; &nbsp; &nbsp; &nbsp; kernel source for this kernel does not seem to =
be installed.<br><br><br><br>
&nbsp; &nbsp; Could you make sure that your linux header for the running ke=
rnel<br>
&nbsp; &nbsp; are installed.<br><br>
&nbsp; &nbsp; 4.4.30-v7+ seems like a custom kernel install.<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; root@ebele-desktop:~#<br><br><br><br>
&nbsp; &nbsp; &nbsp; &nbsp; On Thu, Nov 17, 2016 at 3:00 PM, Jonathan Rajot=
te<br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:jonathan.r.julien@gmail.c=
om" target=3D"_blank">jonathan.r.julien@gmail.com</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:jonathan.r.julien@=
gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a>&gt;<br></div><=
/div>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:jonathan.r.julien@=
gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a><span class=3D"=
"><br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:jonathan.r.julien@=
gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a>&gt;&gt;&gt; wr=
ote:<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hi,<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Could you be a bit more precise r=
egarding which part of the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; documentation does not work ?<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; How did you install it ? Distribu=
tion packages ? From<br>
&nbsp; &nbsp; &nbsp; &nbsp; sources ?<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Cross compiled ?<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; What is your setup ? Raspian for =
the Pi ? Custom kernel<br>
&nbsp; &nbsp; &nbsp; &nbsp; image ?<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Cheers<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; On Thu, Nov 17, 2016 at 2:54 PM, =
Nwafor, Ebelechukwu<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:ebelechukwu=
.nwafor@bison.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bison.howard=
.edu</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:ebelechukwu.nwafor=
@bison.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bison.howard.edu</a=
>&gt;<br></span>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:ebel=
echukwu.nwafor@bison.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bison=
.howard.edu</a><span class=3D""><br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:ebelechukwu.nwafor=
@bison.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bison.howard.edu</a=
>&gt;&gt;&gt; wrote:<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hello.<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; I am trying to inst=
all LTTNG tracing tool on raspberry<br>
&nbsp; &nbsp; &nbsp; &nbsp; pi and<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; beaglebone black bo=
ard.The official LTTNG<br>
&nbsp; &nbsp; &nbsp; &nbsp; documentation does<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; not work on these d=
evices. Does anyone know of any<br>
&nbsp; &nbsp; &nbsp; &nbsp; tutorial<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; that can help me ac=
complish this? Thanks.<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;Ebelechukwu Nwafor,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Graduate Student,<b=
r>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Howard University.<=
br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ___________________=
____________________________<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng-dev mailing l=
ist<br>
&nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"mailto:lttng-dev@lists.lttng.org" ta=
rget=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&=
gt;<br></span>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:lttng-dev@lists.lt=
tng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><span class=3D""><b=
r>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:lttng-dev@lists.lt=
tng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;&lt;<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/ltt=
ng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;&gt;<br>
<br>
<br>
<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --&nbsp; &nbsp; &nbsp;Jonathan Ra=
jotte Julien<br>
<br>
<br>
<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; --&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Ebelechukwu=
 Nwafor,<br>
&nbsp; &nbsp; &nbsp; &nbsp; Graduate Student,<br>
&nbsp; &nbsp; &nbsp; &nbsp; Howard University.<br>
<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; _______________________________________________=
<br>
&nbsp; &nbsp; &nbsp; &nbsp; lttng-dev mailing list<br>
&nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"mailto:lttng-dev@lists.lttng.org" ta=
rget=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&=
gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;<br>
<br>
<br></span>
&nbsp; &nbsp; --&nbsp; &nbsp; &nbsp;Jonathan R. Julien<span class=3D""><br>
&nbsp; &nbsp; Efficios<br>
<br>
<br>
&nbsp; &nbsp; _______________________________________________<br>
&nbsp; &nbsp; lttng-dev mailing list<br></span><span class=3D"">
&nbsp; &nbsp; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank=
">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:lttng-dev@list=
s.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;<br>
&nbsp; &nbsp; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-=
bin/mailman/listinfo/lttng-dev</a><br>
&nbsp; &nbsp; &lt;<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev</a>&gt;<br>
<br>
<br>
<br>
<br>
-- <br></span><span class=3D"">
Ebelechukwu Nwafor,<br>
Graduate Student,<br>
Howard University.<br>
</span></blockquote><br><div class=3D"HOEnZb"><div class=3D"h5">
-- <br>
Jonathan R. Julien<br>
Efficios<br><br></div></div></blockquote></div><br><br clear=3D"all"><br>--=
 <br><div class=3D"gmail_signature"><div dir=3D"ltr">Ebelechukwu Nwafor,<di=
v>Graduate Student,</div><div>Howard University.</div></div></div></div><br=
>_______________________________________________<br>lttng-dev mailing list<=
br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"__SIG_POST__"=
>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com</div></div></body></html>
--=_e524b7f0-f831-402e-97aa-00d0c9e826fa--

--===============5175783118598197961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5175783118598197961==--
