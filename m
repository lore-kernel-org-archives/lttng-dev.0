From: "Nwafor, Ebelechukwu" <ebelechukwu.nwafor@bison.howard.edu>
Subject: Re: Installing LTTNG on beaglebone black or rasberry pi
Date: Fri, 18 Nov 2016 08:09:35 -0500
Message-ID: <CAAuy2ARaNDi5fAUMKEG=a4AcTes=WsDgiiXJxo-uird39+3BpQ__310.239956206892$1479474597$gmane$org@mail.gmail.com>
References: <CAAuy2ATLED2dopcqdjF4+Xpy7wA+OLeTwOvYma+BRkWR9xPKRg@mail.gmail.com>
 <CAF4oYfGS5Vf5CrS3XVFxDQkdrs=wtoNCNw5qOpf_G6_TDBLBsg@mail.gmail.com>
 <CAAuy2AQmRSC4Zg59gALTstfL+gBRTLynfAv0u6vhmgu-TumNpw@mail.gmail.com>
 <d0ef0af1-4c57-34bc-7764-fcf86764773f@efficios.com>
 <CAAuy2AR_efNuciOO46HPiN+dvSOg6RWvpghptgp_QdBwYow80Q@mail.gmail.com>
 <27c01d2b-4b81-9f2c-b4ce-962f529d9c45@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0070436939209268553=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x231.google.com (mail-yw0-x231.google.com
 [IPv6:2607:f8b0:4002:c05::231])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKyzX6HspzdgZ
 for <lttng-dev@lists.lttng.org>; Fri, 18 Nov 2016 13:10:48 +0000 (UTC)
Received: by mail-yw0-x231.google.com with SMTP id a10so163332627ywa.3
 for <lttng-dev@lists.lttng.org>; Fri, 18 Nov 2016 05:09:37 -0800 (PST)
In-Reply-To: <27c01d2b-4b81-9f2c-b4ce-962f529d9c45@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0070436939209268553==
Content-Type: multipart/alternative; boundary=001a1141dd2098e6ef05419304d9

--001a1141dd2098e6ef05419304d9
Content-Type: text/plain; charset=UTF-8

Hello Jonathan.

I have tried every other thing on your last message. Attached is the output
of the lttng-sessiond -vvv


Thanks.


root@ebele-desktop:~# lttng-sessiond -vvv
DEBUG1 - 20:29:17.718632 [8086/8086]: run_as signal handler set for SIGTERM
and SIGINT (in set_worker_sighandlers() at runas.c:600)
DEBUG1 - 20:29:17.719781 [8085/8085]: Health check time delta in seconds
set to 20 (in health_init() at health.c:74)
DEBUG1 - 20:29:17.720333 [8085/8085]: epoll set max size is 334459 (in
compat_epoll_set_max_size() at compat-epoll.c:290)
DEBUG3 - 20:29:17.720888 [8085/8085]: Creating LTTng run directory:
/var/run/lttng (in create_lttng_rundir() at main.c:5156)
DEBUG2 - 20:29:17.721063 [8085/8085]: Kernel consumer err path:
/var/run/lttng/kconsumerd/error (in main() at main.c:5601)
DEBUG2 - 20:29:17.721101 [8085/8085]: Kernel consumer cmd path:
/var/run/lttng/kconsumerd/command (in main() at main.c:5603)
Error: Could not get lock file /var/run/lttng/lttng-sessiond.lck, another
instance is running.
DEBUG1 - 20:29:17.721231 [8085/8085]: Cleanup sessiond (in
sessiond_cleanup() at main.c:622)
DEBUG1 - 20:29:17.721322 [8085/8085]: Removing sessiond and consumerd
content of directory /var/run/lttng (in sessiond_cleanup() at main.c:641)
DEBUG1 - 20:29:17.721360 [8085/8085]: Removing
/var/run/lttng/lttng-sessiond.pid (in sessiond_cleanup() at main.c:647)
DEBUG1 - 20:29:17.721417 [8085/8085]: Removing /var/run/lttng/agent.port
(in sessiond_cleanup() at main.c:652)
DEBUG1 - 20:29:17.721462 [8085/8085]: Removing
/var/run/lttng/kconsumerd/error (in sessiond_cleanup() at main.c:659)
DEBUG1 - 20:29:17.721510 [8085/8085]: Removing directory
/var/run/lttng/kconsumerd (in sessiond_cleanup() at main.c:665)
DEBUG1 - 20:29:17.721558 [8085/8085]: Removing
/var/run/lttng/ustconsumerd32/error (in sessiond_cleanup() at main.c:672)
DEBUG1 - 20:29:17.721602 [8085/8085]: Removing directory
/var/run/lttng/ustconsumerd32 (in sessiond_cleanup() at main.c:678)
DEBUG1 - 20:29:17.721647 [8085/8085]: Removing
/var/run/lttng/ustconsumerd64/error (in sessiond_cleanup() at main.c:685)
DEBUG1 - 20:29:17.721693 [8085/8085]: Removing directory
/var/run/lttng/ustconsumerd64 (in sessiond_cleanup() at main.c:691)
DEBUG1 - 20:29:17.721734 [8085/8085]: Cleaning up all sessions (in
sessiond_cleanup() at main.c:694)
DEBUG1 - 20:29:17.721765 [8085/8085]: Cleaning up all agent apps (in
sessiond_cleanup() at main.c:711)
DEBUG1 - 20:29:17.721796 [8085/8085]: Closing all UST sockets (in
sessiond_cleanup() at main.c:714)
DEBUG2 - 20:29:17.721825 [8085/8085]: UST app cleaning registered apps hash
table (in ust_app_clean_list() at ust-app.c:3702)
DEBUG3 - 20:29:17.721856 [8085/8085]: Buffer registry destroy all registry
(in buffer_reg_destroy_registries() at buffer-registry.c:716)
DEBUG2 - 20:29:17.721886 [8085/8085]: Closing kernel fd (in
sessiond_cleanup() at main.c:719)
DEBUG1 - 20:29:17.721914 [8085/8085]: Unloading kernel modules (in
sessiond_cleanup() at main.c:726)
DEBUG1 - 20:29:17.722118 [8085/8087]: [ht-thread] startup. (in
thread_ht_cleanup() at ht-cleanup.c:37)
DEBUG3 - 20:29:17.723951 [8085/8087]: [ht-thread] Polling. (in
thread_ht_cleanup() at ht-cleanup.c:67)
DEBUG1 - 20:29:17.736599 [8085/8085]: Modprobe removal successful
lttng-kretprobes (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG1 - 20:29:17.750243 [8085/8085]: Modprobe removal successful
lttng-kprobes (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG1 - 20:29:17.763239 [8085/8085]: Modprobe removal successful
lttng-ftrace (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG1 - 20:29:17.778109 [8085/8085]: Modprobe removal successful
lttng-types (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG1 - 20:29:17.793153 [8085/8085]: Modprobe removal successful
lttng-ring-buffer-metadata-mmap-client (in modprobe_remove_lttng() at
modprobe.c:126)
DEBUG1 - 20:29:17.810951 [8085/8085]: Modprobe removal successful
lttng-ring-buffer-client-mmap-overwrite (in modprobe_remove_lttng() at
modprobe.c:126)
DEBUG1 - 20:29:17.823876 [8085/8085]: Modprobe removal successful
lttng-ring-buffer-client-mmap-discard (in modprobe_remove_lttng() at
modprobe.c:126)
DEBUG1 - 20:29:17.836698 [8085/8085]: Modprobe removal successful
lttng-ring-buffer-metadata-client (in modprobe_remove_lttng() at
modprobe.c:126)
DEBUG1 - 20:29:17.849417 [8085/8085]: Modprobe removal successful
lttng-ring-buffer-client-overwrite (in modprobe_remove_lttng() at
modprobe.c:126)
DEBUG1 - 20:29:17.864495 [8085/8085]: Modprobe removal successful
lttng-ring-buffer-client-discard (in modprobe_remove_lttng() at
modprobe.c:126)
DEBUG1 - 20:29:17.879363 [8085/8085]: Modprobe removal successful
lttng-lib-ring-buffer (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG1 - 20:29:17.896710 [8085/8085]: Modprobe removal successful
lttng-tracer (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG3 - 20:29:17.897048 [8085/8087]: [ht-thread] Returning from poll on 2
fds. (in thread_ht_cleanup() at ht-cleanup.c:74)
DEBUG1 - 20:29:17.897154 [8085/8087]: [ht-cleanup] quit. (in
thread_ht_cleanup() at ht-cleanup.c:153)
DEBUG1 - 20:29:17.897262 [8085/8087]: [ht-cleanup] Thread terminates. (in
thread_ht_cleanup() at ht-cleanup.c:164)
DEBUG1 - 20:29:17.897743 [8085/8085]: Cleaning up options (in
sessiond_cleanup_options() at main.c:773)
DEBUG1 - 20:29:17.901442 [8085/8085]: lttng-runas terminated with status
code 0 (in run_as_destroy_worker() at runas.c:737)
DEBUG1 - 20:29:17.901548 [8085/8085]: *** assert failed :-) *** ==>
Matthew, BEET driven development works! (in sessiond_cleanup_options() at
main.c:805)
root@ebele-desktop:~#

On Thu, Nov 17, 2016 at 7:38 PM, Jonathan Rajotte Julien <
Jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On 2016-11-17 07:24 PM, Nwafor, Ebelechukwu wrote:
>
>> Thanks Jonathan for you helpful response. I was able to install the
>> specific linux-headers and it seems to install all of the modules. Now i've
>> hit another roadblock. whenever i try to list all of the kernel events
>> using lttng list -k, it throws an error: unable to list kernel events:
>> Kernel tracer is not available. I have two lttng-sessiond running.
>>
>
> Terminate both of them. Since you installed it from apt-get the
> lttng-tools package provide a service for lttng-sessiond implying that the
> lttng-sessiond process should get restarted automatically if killed.
>
> Again, make sure that the user issuing the "lttng list -k" is part of the
> "tracing" group or simply root.
>
> If this still does not work refer to the last email and stop the service
> then, as root, launch "lttng-sessiond -vvv" and check the output to make
> sure that the modules gets loaded.
>
> Open another terminal and test the kernel tracepoint listing.
>
> If this does not work make sure to include the output from "lttng-sessiond
> -vvv" in your next email.
>
> Cheers
>
>>
>> On Thu, Nov 17, 2016 at 4:45 PM, Jonathan Rajotte Julien <
>> Jonathan.rajotte-julien@efficios.com <mailto:Jonathan.rajotte-julie
>> n@efficios.com>> wrote:
>>
>>     Hi,
>>
>>
>>     On 2016-11-17 04:24 PM, Nwafor, Ebelechukwu wrote:
>>
>>         Hi Jonathan. Thank you for your response.
>>
>>         On the beaglebone black, i tried building lttng-tools,
>>         lttng-modules-dkms and lttng-ust-dev from source v2.8.1 by
>>         following the documentation. lttng-modules-dkms runs fine but
>>         the module does not show up on the list of running modules
>>         when i issue an lsmod command. Also, i run into errors while
>>         trying to build and compile lttng-tools. Beaglebone black runs
>>         on debian. Linux beaglebone 3.8.13-bone70 #1 SMP Fri Jan 23
>>         02:15:42 UTC 2015 armv7l GNU/Linux
>>
>>
>>     What errors do you see when building lttng-tools?
>>
>>
>>
>>         On the raspberry pi, I use the commands, apt-get install
>>         lttng-modules-dkms lttng-tools lttng-ust-dev. Everything seems
>>         to work fine with the exception of lttng-modules-dkms which
>>         does not show up on the list on running modules. Also, every
>>         time i try to view available kernel events, it comes up with
>>         an error saying unable to list kernel events: kernel tracer
>>         not available. The LTTNG version installed using apt-get is
>>         2.7.1. I am running ubuntu mate OS. Below are the output while
>>         installing lttng-modules-dkms
>>
>>
>>     Well as the error points out do you have the kernel tracer started?
>>
>>     ps -aux | grep lttng-sessiond
>>
>>     Does the user trying to use lttng is part of the tracing group or
>>     is root ?
>>
>>     You can start lttng-sessiond with the -vvv options make sure to be
>>     root when doing so lttng-sessiond load the tracing modules.
>>
>>     Since you installed it from apt-get the lttng-tools package
>>     provide a daemon for lttng-sessiond so before testing manually:
>>
>>     service lttng-sessiond stop
>>
>>
>>
>>         root@ebele-desktop:~# apt-get install lttng-modules-dkms
>>         Reading package lists... Done
>>         Building dependency tree
>>         Reading state information... Done
>>         lttng-modules-dkms is already the newest version (2.7.1-1).
>>         0 upgraded, 0 newly installed, 0 to remove and 14 not upgraded.
>>         2 not fully installed or removed.
>>         After this operation, 0 B of additional disk space will be used.
>>         Do you want to continue? [Y/n] Y
>>         Setting up linux-headers-4.4.0-22 (4.4.0-22.40) ...
>>         Setting up lttng-modules-dkms (2.7.1-1) ...
>>         Loading new lttng-modules-2.7.1 DKMS files...
>>         First Installation: checking all kernels...
>>         dpkg: warning: version '*-*' has bad syntax: version number
>>         does not start with digit
>>         It is likely that 4.4.30-v7+ belongs to a chroot's host
>>         Module build for the currently running kernel was skipped
>>         since the
>>         kernel source for this kernel does not seem to be installed.
>>
>>
>>
>>     Could you make sure that your linux header for the running kernel
>>     are installed.
>>
>>     4.4.30-v7+ seems like a custom kernel install.
>>
>>         root@ebele-desktop:~#
>>
>>
>>
>>         On Thu, Nov 17, 2016 at 3:00 PM, Jonathan Rajotte
>>         <jonathan.r.julien@gmail.com
>>         <mailto:jonathan.r.julien@gmail.com>
>>         <mailto:jonathan.r.julien@gmail.com
>>         <mailto:jonathan.r.julien@gmail.com>>> wrote:
>>
>>             Hi,
>>
>>             Could you be a bit more precise regarding which part of the
>>             documentation does not work ?
>>
>>             How did you install it ? Distribution packages ? From
>>         sources ?
>>             Cross compiled ?
>>
>>             What is your setup ? Raspian for the Pi ? Custom kernel
>>         image ?
>>
>>             Cheers
>>
>>             On Thu, Nov 17, 2016 at 2:54 PM, Nwafor, Ebelechukwu
>>             <ebelechukwu.nwafor@bison.howard.edu
>>         <mailto:ebelechukwu.nwafor@bison.howard.edu>
>>             <mailto:ebelechukwu.nwafor@bison.howard.edu
>>         <mailto:ebelechukwu.nwafor@bison.howard.edu>>> wrote:
>>
>>                 Hello.
>>
>>                 I am trying to install LTTNG tracing tool on raspberry
>>         pi and
>>                 beaglebone black board.The official LTTNG
>>         documentation does
>>                 not work on these devices. Does anyone know of any
>>         tutorial
>>                 that can help me accomplish this? Thanks.
>>
>>                 --         Ebelechukwu Nwafor,
>>                 Graduate Student,
>>                 Howard University.
>>
>>                 _______________________________________________
>>                 lttng-dev mailing list
>>         lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>>         <mailto:lttng-dev@lists.lttng.org
>>         <mailto:lttng-dev@lists.lttng.org>>
>>         https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>         <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
>>                        <https://lists.lttng.org/cgi-
>> bin/mailman/listinfo/lttng-dev
>>         <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>>
>>
>>
>>
>>
>>             --     Jonathan Rajotte Julien
>>
>>
>>
>>
>>         --         Ebelechukwu Nwafor,
>>         Graduate Student,
>>         Howard University.
>>
>>
>>         _______________________________________________
>>         lttng-dev mailing list
>>         lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>>         https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>         <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
>>
>>
>>     --     Jonathan R. Julien
>>     Efficios
>>
>>
>>     _______________________________________________
>>     lttng-dev mailing list
>>     lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>>     https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>     <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
>>
>>
>>
>>
>> --
>> Ebelechukwu Nwafor,
>> Graduate Student,
>> Howard University.
>>
>
> --
> Jonathan R. Julien
> Efficios
>
>


-- 
Ebelechukwu Nwafor,
Graduate Student,
Howard University.

--001a1141dd2098e6ef05419304d9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Jonathan.</div><div><br></div><div>I have tried=
 every other thing on your last message. Attached is the output of the lttn=
g-sessiond -vvv</div><div><br></div><div><br></div><div>Thanks.</div><div><=
br></div><div><br></div>root@ebele-desktop:~# lttng-sessiond -vvv<br>DEBUG1=
 - 20:29:17.718632 [8086/8086]: run_as signal handler set for SIGTERM and S=
IGINT (in set_worker_sighandlers() at runas.c:600)<br>DEBUG1 - 20:29:17.719=
781 [8085/8085]: Health check time delta in seconds set to 20 (in health_in=
it() at health.c:74)<br>DEBUG1 - 20:29:17.720333 [8085/8085]: epoll set max=
 size is 334459 (in compat_epoll_set_max_size() at compat-epoll.c:290)<br>D=
EBUG3 - 20:29:17.720888 [8085/8085]: Creating LTTng run directory: /var/run=
/lttng (in create_lttng_rundir() at main.c:5156)<br>DEBUG2 - 20:29:17.72106=
3 [8085/8085]: Kernel consumer err path: /var/run/lttng/kconsumerd/erro<wbr=
>r (in main() at main.c:5601)<br>DEBUG2 - 20:29:17.721101 [8085/8085]: Kern=
el consumer cmd path: /var/run/lttng/kconsumerd/comm<wbr>and (in main() at =
main.c:5603)<br>Error: Could not get lock file /var/run/lttng/lttng-session=
d.<wbr>lck, another instance is running.<br>DEBUG1 - 20:29:17.721231 [8085/=
8085]: Cleanup sessiond (in sessiond_cleanup() at main.c:622)<br>DEBUG1 - 2=
0:29:17.721322 [8085/8085]: Removing sessiond and consumerd content of dire=
ctory /var/run/lttng (in sessiond_cleanup() at main.c:641)<br>DEBUG1 - 20:2=
9:17.721360 [8085/8085]: Removing /var/run/lttng/lttng-sessiond.<wbr>pid (i=
n sessiond_cleanup() at main.c:647)<br>DEBUG1 - 20:29:17.721417 [8085/8085]=
: Removing /var/run/lttng/agent.port (in sessiond_cleanup() at main.c:652)<=
br>DEBUG1 - 20:29:17.721462 [8085/8085]: Removing /var/run/lttng/kconsumerd=
/erro<wbr>r (in sessiond_cleanup() at main.c:659)<br>DEBUG1 - 20:29:17.7215=
10 [8085/8085]: Removing directory /var/run/lttng/kconsumerd (in sessiond_c=
leanup() at main.c:665)<br>DEBUG1 - 20:29:17.721558 [8085/8085]: Removing /=
var/run/lttng/ustconsumerd32/<wbr>error (in sessiond_cleanup() at main.c:67=
2)<br>DEBUG1 - 20:29:17.721602 [8085/8085]: Removing directory /var/run/ltt=
ng/ustconsumerd32 (in sessiond_cleanup() at main.c:678)<br>DEBUG1 - 20:29:1=
7.721647 [8085/8085]: Removing /var/run/lttng/ustconsumerd64/<wbr>error (in=
 sessiond_cleanup() at main.c:685)<br>DEBUG1 - 20:29:17.721693 [8085/8085]:=
 Removing directory /var/run/lttng/ustconsumerd64 (in sessiond_cleanup() at=
 main.c:691)<br>DEBUG1 - 20:29:17.721734 [8085/8085]: Cleaning up all sessi=
ons (in sessiond_cleanup() at main.c:694)<br>DEBUG1 - 20:29:17.721765 [8085=
/8085]: Cleaning up all agent apps (in sessiond_cleanup() at main.c:711)<br=
>DEBUG1 - 20:29:17.721796 [8085/8085]: Closing all UST sockets (in sessiond=
_cleanup() at main.c:714)<br>DEBUG2 - 20:29:17.721825 [8085/8085]: UST app =
cleaning registered apps hash table (in ust_app_clean_list() at ust-app.c:3=
702)<br>DEBUG3 - 20:29:17.721856 [8085/8085]: Buffer registry destroy all r=
egistry (in buffer_reg_destroy_registries(<wbr>) at buffer-registry.c:716)<=
br>DEBUG2 - 20:29:17.721886 [8085/8085]: Closing kernel fd (in sessiond_cle=
anup() at main.c:719)<br>DEBUG1 - 20:29:17.721914 [8085/8085]: Unloading ke=
rnel modules (in sessiond_cleanup() at main.c:726)<br>DEBUG1 - 20:29:17.722=
118 [8085/8087]: [ht-thread] startup. (in thread_ht_cleanup() at ht-cleanup=
.c:37)<br>DEBUG3 - 20:29:17.723951 [8085/8087]: [ht-thread] Polling. (in th=
read_ht_cleanup() at ht-cleanup.c:67)<br>DEBUG1 - 20:29:17.736599 [8085/808=
5]: Modprobe removal successful lttng-kretprobes (in modprobe_remove_lttng(=
) at modprobe.c:126)<br>DEBUG1 - 20:29:17.750243 [8085/8085]: Modprobe remo=
val successful lttng-kprobes (in modprobe_remove_lttng() at modprobe.c:126)=
<br>DEBUG1 - 20:29:17.763239 [8085/8085]: Modprobe removal successful lttng=
-ftrace (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:17=
.778109 [8085/8085]: Modprobe removal successful lttng-types (in modprobe_r=
emove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:17.793153 [8085/8085]: M=
odprobe removal successful lttng-ring-buffer-metadata-mma<wbr>p-client (in =
modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:17.810951 [808=
5/8085]: Modprobe removal successful lttng-ring-buffer-client-mmap-<wbr>ove=
rwrite (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - 20:29:17.=
823876 [8085/8085]: Modprobe removal successful lttng-ring-buffer-client-mm=
ap-<wbr>discard (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1 - =
20:29:17.836698 [8085/8085]: Modprobe removal successful lttng-ring-buffer-=
metadata-cli<wbr>ent (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBU=
G1 - 20:29:17.849417 [8085/8085]: Modprobe removal successful lttng-ring-bu=
ffer-client-overw<wbr>rite (in modprobe_remove_lttng() at modprobe.c:126)<b=
r>DEBUG1 - 20:29:17.864495 [8085/8085]: Modprobe removal successful lttng-r=
ing-buffer-client-disca<wbr>rd (in modprobe_remove_lttng() at modprobe.c:12=
6)<br>DEBUG1 - 20:29:17.879363 [8085/8085]: Modprobe removal successful ltt=
ng-lib-ring-buffer (in modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG1=
 - 20:29:17.896710 [8085/8085]: Modprobe removal successful lttng-tracer (i=
n modprobe_remove_lttng() at modprobe.c:126)<br>DEBUG3 - 20:29:17.897048 [8=
085/8087]: [ht-thread] Returning from poll on 2 fds. (in thread_ht_cleanup(=
) at ht-cleanup.c:74)<br>DEBUG1 - 20:29:17.897154 [8085/8087]: [ht-cleanup]=
 quit. (in thread_ht_cleanup() at ht-cleanup.c:153)<br>DEBUG1 - 20:29:17.89=
7262 [8085/8087]: [ht-cleanup] Thread terminates. (in thread_ht_cleanup() a=
t ht-cleanup.c:164)<br>DEBUG1 - 20:29:17.897743 [8085/8085]: Cleaning up op=
tions (in sessiond_cleanup_options() at main.c:773)<br>DEBUG1 - 20:29:17.90=
1442 [8085/8085]: lttng-runas terminated with status code 0 (in run_as_dest=
roy_worker() at runas.c:737)<br>DEBUG1 - 20:29:17.901548 [8085/8085]: *** a=
ssert failed :-) *** =3D=3D&gt; Matthew, BEET driven development works! (in=
 sessiond_cleanup_options() at main.c:805)<br>root@ebele-desktop:~#=C2=A0<b=
r></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, N=
ov 17, 2016 at 7:38 PM, Jonathan Rajotte Julien <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:Jonathan.rajotte-julien@efficios.com" target=3D"_blank">Jonath=
an.rajotte-julien@efficios.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<span class=3D""><br>
<br>
On 2016-11-17 07:24 PM, Nwafor, Ebelechukwu wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Thanks Jonathan for you helpful response. I was able to install the specifi=
c linux-headers and it seems to install all of the modules. Now i&#39;ve hi=
t another roadblock. whenever i try to list all of the kernel events using =
lttng list -k, it throws an error: unable to list kernel events: Kernel tra=
cer is not available. I have two lttng-sessiond running.<br>
</blockquote>
<br></span>
Terminate both of them. Since you installed it from apt-get the lttng-tools=
 package provide a service for lttng-sessiond implying that the lttng-sessi=
ond process should get restarted automatically if killed.<br>
<br>
Again, make sure that the user issuing the &quot;lttng list -k&quot; is par=
t of the &quot;tracing&quot; group or simply root.<br>
<br>
If this still does not work refer to the last email and stop the service th=
en, as root, launch &quot;lttng-sessiond -vvv&quot; and check the output to=
 make sure that the modules gets loaded.<br>
<br>
Open another terminal and test the kernel tracepoint listing.<br>
<br>
If this does not work make sure to include the output from &quot;lttng-sess=
iond -vvv&quot; in your next email.<br>
<br>
Cheers<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div class=3D"h5">
<br>
On Thu, Nov 17, 2016 at 4:45 PM, Jonathan Rajotte Julien &lt;<a href=3D"mai=
lto:Jonathan.rajotte-julien@efficios.com" target=3D"_blank">Jonathan.rajott=
e-julien@effic<wbr>ios.com</a> &lt;mailto:<a href=3D"mailto:Jonathan.rajott=
e-julien@efficios.com" target=3D"_blank">Jonathan.rajotte-julie<wbr>n@effic=
ios.com</a>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 Hi,<br>
<br>
<br>
=C2=A0 =C2=A0 On 2016-11-17 04:24 PM, Nwafor, Ebelechukwu wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi Jonathan. Thank you for your response.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 On the beaglebone black, i tried building lttng=
-tools,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-modules-dkms and lttng-ust-dev from sourc=
e v2.8.1 by<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 following the documentation. lttng-modules-dkms=
 runs fine but<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the module does not show up on the list of runn=
ing modules<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 when i issue an lsmod command. Also, i run into=
 errors while<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 trying to build and compile lttng-tools. Beagle=
bone black runs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 on debian. Linux beaglebone 3.8.13-bone70 #1 SM=
P Fri Jan 23<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 02:15:42 UTC 2015 armv7l GNU/Linux<br>
<br>
<br>
=C2=A0 =C2=A0 What errors do you see when building lttng-tools?<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 On the raspberry pi, I use the commands, apt-ge=
t install<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-modules-dkms lttng-tools lttng-ust-dev. E=
verything seems<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 to work fine with the exception of lttng-module=
s-dkms which<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 does not show up on the list on running modules=
. Also, every<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 time i try to view available kernel events, it =
comes up with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 an error saying unable to list kernel events: k=
ernel tracer<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 not available. The LTTNG version installed usin=
g apt-get is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 2.7.1. I am running ubuntu mate OS. Below are t=
he output while<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 installing lttng-modules-dkms<br>
<br>
<br>
=C2=A0 =C2=A0 Well as the error points out do you have the kernel tracer st=
arted?<br>
<br>
=C2=A0 =C2=A0 ps -aux | grep lttng-sessiond<br>
<br>
=C2=A0 =C2=A0 Does the user trying to use lttng is part of the tracing grou=
p or<br>
=C2=A0 =C2=A0 is root ?<br>
<br>
=C2=A0 =C2=A0 You can start lttng-sessiond with the -vvv options make sure =
to be<br>
=C2=A0 =C2=A0 root when doing so lttng-sessiond load the tracing modules.<b=
r>
<br>
=C2=A0 =C2=A0 Since you installed it from apt-get the lttng-tools package<b=
r>
=C2=A0 =C2=A0 provide a daemon for lttng-sessiond so before testing manuall=
y:<br>
<br>
=C2=A0 =C2=A0 service lttng-sessiond stop<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 root@ebele-desktop:~# apt-get install lttng-mod=
ules-dkms<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Reading package lists... Done<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Building dependency tree<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Reading state information... Done<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-modules-dkms is already the newest versio=
n (2.7.1-1).<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0 upgraded, 0 newly installed, 0 to remove and =
14 not upgraded.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 2 not fully installed or removed.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 After this operation, 0 B of additional disk sp=
ace will be used.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Do you want to continue? [Y/n] Y<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Setting up linux-headers-4.4.0-22 (4.4.0-22.40)=
 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Setting up lttng-modules-dkms (2.7.1-1) ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Loading new lttng-modules-2.7.1 DKMS files...<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 First Installation: checking all kernels...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpkg: warning: version &#39;*-*&#39; has bad sy=
ntax: version number<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 does not start with digit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 It is likely that 4.4.30-v7+ belongs to a chroo=
t&#39;s host<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Module build for the currently running kernel w=
as skipped<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 since the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel source for this kernel does not seem to =
be installed.<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 Could you make sure that your linux header for the running ke=
rnel<br>
=C2=A0 =C2=A0 are installed.<br>
<br>
=C2=A0 =C2=A0 4.4.30-v7+ seems like a custom kernel install.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 root@ebele-desktop:~#<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 On Thu, Nov 17, 2016 at 3:00 PM, Jonathan Rajot=
te<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jonathan.r.julien@gmail.c=
om" target=3D"_blank">jonathan.r.julien@gmail.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jonathan.r.julien@=
gmail.com" target=3D"_blank">jonathan.r.julien@gmai<wbr>l.com</a>&gt;<br></=
div></div>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jonathan.r.julien@=
gmail.com" target=3D"_blank">jonathan.r.julien@gmai<wbr>l.com</a><span clas=
s=3D""><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jonathan.r.julien@=
gmail.com" target=3D"_blank">jonathan.r.julien@gmai<wbr>l.com</a>&gt;&gt;&g=
t; wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Could you be a bit more precise r=
egarding which part of the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 documentation does not work ?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 How did you install it ? Distribu=
tion packages ? From<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sources ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cross compiled ?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 What is your setup ? Raspian for =
the Pi ? Custom kernel<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 image ?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cheers<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Thu, Nov 17, 2016 at 2:54 PM, =
Nwafor, Ebelechukwu<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:ebelechukwu=
.nwafor@bison.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bison.howa<w=
br>rd.edu</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:ebelechukwu.nwafor=
@bison.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bis<wbr>on.howard.e=
du</a>&gt;<br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:ebel=
echukwu.nwafor@bison.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bis<w=
br>on.howard.edu</a><span class=3D""><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:ebelechukwu.nwafor=
@bison.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bis<wbr>on.howard.e=
du</a>&gt;&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hello.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I am trying to inst=
all LTTNG tracing tool on raspberry<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pi and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 beaglebone black bo=
ard.The official LTTNG<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 documentation does<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 not work on these d=
evices. Does anyone know of any<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tutorial<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that can help me ac=
complish this? Thanks.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Ebelechukwu Nwafor,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Graduate Student,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Howard University.<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ___________________=
___________<wbr>_________________<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-dev mailing l=
ist<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists.lttng.org" ta=
rget=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.<wbr>org=
</a>&gt;<br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:lttng-dev@lists.lt=
tng.org" target=3D"_blank">lttng-dev@lists.lttng.<wbr>org</a><span class=3D=
""><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:lttng-dev@lists.lt=
tng.org" target=3D"_blank">lttng-dev@lists.lttng.<wbr>org</a>&gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bi<wbr>n/mailman/listinfo/lttng-dev</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.lttng.org/cgi-b<wbr>in/mailman/listinfo/lttng-dev</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&lt;<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-=
<wbr>bin/mailman/listinfo/lttng-dev</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.lttng.org/cgi-b<wbr>in/mailman/listinfo/lttng-dev</a>&gt;<wbr>&gt;<br>
<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A0Jonathan Ra=
jotte Julien<br>
<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ebelechukwu=
 Nwafor,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Graduate Student,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Howard University.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ______________________________<wbr>____________=
_____<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-dev mailing list<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists.lttng.org" ta=
rget=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.<wbr>org=
</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bi<wbr>n/mailman/listinfo/lttng-dev</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.lttng.org/cgi-b<wbr>in/mailman/listinfo/lttng-dev</a>&gt;<br>
<br>
<br></span>
=C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A0Jonathan R. Julien<span class=3D""><br>
=C2=A0 =C2=A0 Efficios<br>
<br>
<br>
=C2=A0 =C2=A0 ______________________________<wbr>_________________<br>
=C2=A0 =C2=A0 lttng-dev mailing list<br></span><span class=3D"">
=C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank=
">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:lttng-dev@list=
s.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.<wbr>org</a>&gt;<br>
=C2=A0 =C2=A0 <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-=
bi<wbr>n/mailman/listinfo/lttng-dev</a><br>
=C2=A0 =C2=A0 &lt;<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/=
cgi-b<wbr>in/mailman/listinfo/lttng-dev</a>&gt;<br>
<br>
<br>
<br>
<br>
-- <br></span><span class=3D"">
Ebelechukwu Nwafor,<br>
Graduate Student,<br>
Howard University.<br>
</span></blockquote>
<br><div class=3D"HOEnZb"><div class=3D"h5">
-- <br>
Jonathan R. Julien<br>
Efficios<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Ebelechukwu Nwafor,<div>Graduate Student,</div><div>Howard Univers=
ity.</div></div></div>
</div>

--001a1141dd2098e6ef05419304d9--

--===============0070436939209268553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0070436939209268553==--
