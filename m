From: Neil Bryan <Neil.Bryan@ttp.com>
Subject: Re: Inappropriate ioctl for device error
Date: Mon, 16 Mar 2015 11:22:27 +0000
Message-ID: <8369DAE2C5B8814998E89CE414A915381F6BA484__20829.9940488816$1426505042$gmane$org@IT-Mailbox3.TTPGroup.com>
References: <8369DAE2C5B8814998E89CE414A915381F6BA2BF@IT-Mailbox3.TTPGroup.com>
 <5503323A.1020505@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.167])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Neil.Bryan@ttp.com>) id 1YXT6N-0006Pk-Qi
 for lttng-dev@lists.lttng.org; Mon, 16 Mar 2015 07:22:38 -0400
In-Reply-To: <5503323A.1020505@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jonathan,

Please see below:

-----Original Message-----
From: Jonathan Rajotte Julien [mailto:Jonathan.rajotte-julien@efficios.com] =

Sent: Friday, March 13, 2015 6:54 PM
To: Neil Bryan
Subject: Re: [lttng-dev] Inappropriate ioctl for device error

Hey Neil,

Could you send me more detail on the session creation ?

Thanks for looking at this.

Here is the output from session daemon creation:

root@socfpga_cyclone5:~# lttng-sessiond -vvv
DEBUG3 [311/311]: Creating LTTng run directory: /var/run/lttng (in create_l=
ttng_rundir() at main.c:4297)
DEBUG2 [311/311]: Kernel consumer err path: /var/run/lttng/kconsumerd/error=
 (in main() at main.c:4638)
DEBUG2 [311/311]: Kernel consumer cmd path: /var/run/lttng/kconsumerd/comma=
nd (in main() at main.c:4640)
DEBUG1 [311/311]: Client socket path /var/run/lttng/client-lttng-sessiond (=
in main() at main.c:4693)
DEBUG1 [311/311]: Application socket path /var/run/lttng/lttng-ust-sock-5 (=
in main() at main.c:4694)
DEBUG1 [311/311]: Application wait path /lttng-ust-wait-5 (in main() at mai=
n.c:4695)
DEBUG1 [311/311]: LTTng run directory path: /var/run/lttng (in main() at ma=
in.c:4696)
DEBUG2 [311/311]: UST consumer 32 bits err path: /var/run/lttng/ustconsumer=
d32/error (in main() at main.c:4705)
DEBUG2 [311/311]: UST consumer 32 bits cmd path: /var/run/lttng/ustconsumer=
d32/command (in main() at main.c:4707)
DEBUG2 [311/311]: UST consumer 64 bits err path: /var/run/lttng/ustconsumer=
d64/error (in main() at main.c:4716)
DEBUG2 [311/311]: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumer=
d64/command (in main() at main.c:4718)
DEBUG3 [311/311]: Created hashtable size 4 at 0x71080 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [311/311]: Created hashtable size 4 at 0x711f0 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [311/311]: Created hashtable size 4 at 0x71398 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [311/311]: Created hashtable size 4 at 0x71540 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG2 [311/311]: Creating consumer directory: /var/run/lttng/kconsumerd (i=
n set_consumer_sockets() at main.c:4339)
Warning: No tracing group detected
DEBUG1 [311/311]: Modprobe successfully lttng-tracer (in modprobe_lttng_con=
trol() at modprobe.c:192)
DEBUG2 [311/311]: Kernel tracer version validated (major version 2) (in ker=
nel_validate_version() at kernel.c:704)
DEBUG1 [311/311]: Modprobe successfully lttng-ftrace (in modprobe_lttng_dat=
a() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-kprobes (in modprobe_lttng_da=
ta() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-kretprobes (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-lib-ring-buffer (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-ring-buffer-client-discard (i=
n modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-ring-buffer-client-overwrite =
(in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-ring-buffer-metadata-client (=
in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-ring-buffer-client-mmap-disca=
rd (in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-ring-buffer-client-mmap-overw=
rite (in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-ring-buffer-metadata-mmap-cli=
ent (in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-types (in modprobe_lttng_data=
() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-asoc (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-block (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-btrfs (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-compaction (in modprobe=
_lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-ext3 (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-ext4 (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-gpio (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-irq (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-jbd (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-jbd2 (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-kmem (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-kvm (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-kvm-x86 (in modprobe_lt=
tng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-kvm-x86-mmu (in modprob=
e_lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-lock (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-module (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-napi (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-net (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-power (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-printk (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-random (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-rcu (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-regmap (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-regulator (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-rpm (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-sched (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-scsi (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-signal (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-skb (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-sock (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-statedump (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-sunrpc (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-timer (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-udp (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-vmscan (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-workqueue (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Modprobe successfully lttng-probe-writeback (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [311/311]: Kernel tracer fd 6 (in init_kernel_tracer() at main.c:239=
8)
DEBUG2 [311/311]: Creating consumer directory: /var/run/lttng/ustconsumerd6=
4 (in set_consumer_sockets() at main.c:4339)
DEBUG2 [311/311]: Creating consumer directory: /var/run/lttng/ustconsumerd3=
2 (in set_consumer_sockets() at main.c:4339)
DEBUG3 [311/311]: Session daemon client socket 9 and application socket 10 =
created (in init_daemon_socket() at main.c:4205)
DEBUG1 [311/311]: All permissions are set (in set_permissions() at main.c:4=
285)
DEBUG3 [311/311]: Created hashtable size 4 at 0x726e0 of type 2 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [311/311]: Global buffer per UID registry initialized (in buffer_reg=
_init_uid_registry() at buffer-registry.c:99)
DEBUG3 [311/311]: Created hashtable size 4 at 0x72868 of type 2 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [311/311]: Global buffer per PID registry initialized (in buffer_reg=
_init_pid_registry() at buffer-registry.c:220)
DEBUG1 [311/311]: epoll set max size is 89088 (in compat_epoll_set_max_size=
() at compat-epoll.c:290)
DEBUG1 [311/311]: Command subsystem initialized (in cmd_init() at cmd.c:311=
0)
DEBUG1 [311/311]: Pid 311 written in file /var/run/lttng/lttng-sessiond.pid=
 (in utils_create_pid_file() at utils.c:465)
DEBUG1 [311/311]: Pid 5345 written in file /var/run/lttng/jul.port (in util=
s_create_pid_file() at utils.c:465)
DEBUG1 [311/311]: TCP inet operation timeout set to 216 sec (in lttcomm_ine=
t_init() at inet.c:529)
DEBUG1 [311/311]: Health check time delta in seconds set to 236 (in health_=
init() at health.c:73)
DEBUG1 [311/410]: [ht-thread] startup. (in thread_ht_cleanup() at ht-cleanu=
p.c:36)
DEBUG3 [311/410]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at =
ht-cleanup.c:64)
DEBUG1 [311/411]: [thread] Manage health check started (in thread_manage_he=
alth() at main.c:3545)
DEBUG1 [311/412]: [thread] Manage client started (in thread_manage_clients(=
) at main.c:3731)
DEBUG1 [311/414]: [thread] Manage application registration started (in thre=
ad_registration_apps() at main.c:1801)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [311/413]: [thread] Dispatch UST command started (in thread_dispatch=
_ust_registration() at main.c:1577)
DEBUG1 [311/413]: Futex n to 1 prepare done (in futex_nto1_prepare() at fut=
ex.c:75)
DEBUG1 [311/414]: Notifying applications of session daemon state: 1 (in not=
ify_ust_apps() at main.c:628)
DEBUG1 [311/413]: Woken up but nothing in the UST command queue (in thread_=
dispatch_ust_registration() at main.c:1600)
DEBUG1 [311/418]: [thread] Thread manage kernel started (in thread_manage_k=
ernel() at main.c:829)
DEBUG1 [311/418]: Updating kernel poll set (in update_kernel_poll() at main=
.c:689)
DEBUG1 [311/418]: Thread kernel polling on 2 fds (in thread_manage_kernel()=
 at main.c:874)
DEBUG1 [311/411]: Health check ready (in thread_manage_health() at main.c:3=
610)
DEBUG1 [311/414]: Got the wait shm fd 24 (in get_wait_shm() at shm.c:115)
DEBUG1 [311/416]: [ust-thread] Manage application notify command (in ust_th=
read_manage_notify() at ust-thread.c:39)
DEBUG1 [311/414]: Futex wait update active 1 (in futex_wait_update() at fut=
ex.c:63)
DEBUG1 [311/414]: Accepting application registration (in thread_registratio=
n_apps() at main.c:1838)
DEBUG3 [311/416]: [ust-thread] Manage notify polling on 2 fds (in ust_threa=
d_manage_notify() at ust-thread.c:68)
DEBUG1 [311/415]: [thread] Manage application started (in thread_manage_app=
s() at main.c:1291)
DEBUG1 [311/417]: [jul-thread] Manage JUL application registration. (in jul=
_thread_manage_registration() at jul-thread.c:258)
DEBUG1 [311/415]: Apps thread polling on 2 fds (in thread_manage_apps() at =
main.c:1321)
DEBUG3 [311/417]: URI string: tcp://localhost (in uri_parse() at uri.c:291)
DEBUG2 [311/417]: IP address resolved to 127.0.0.1 (in set_ip_address() at =
uri.c:132)
DEBUG3 [311/417]: URI dtype: 1, proto: 1, host: localhost, subdir: , ctrl: =
0, data: 0 (in uri_parse() at uri.c:505)
DEBUG1 [311/417]: [jul-thread] Listening on TCP port 5345 and socket 28 (in=
 init_tcp_socket() at jul-thread.c:156)
DEBUG3 [311/417]: [jul-thread] Manage JUL polling on 2 fds (in jul_thread_m=
anage_registration() at jul-thread.c:286)

Here is the output from the following commands:

lttng create

DEBUG1 [311/412]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [311/412]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [311/412]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [311/412]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [311/412]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [311/412]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [311/412]: Processing client command 8 (in process_client_msg() at m=
ain.c:2637)
DEBUG1 [311/412]: Waiting for 1 URIs from client ... (in process_client_msg=
() at main.c:3201)
DEBUG2 [311/412]: Trying to find session by name auto-20150316-101519 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [311/412]: Created hashtable size 4 at 0x786d8 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG1 [311/412]: Tracing session auto-20150316-101519 created with ID 0 by=
 UID 0 GID 0 (in session_create() at session.c:276)
DEBUG2 [311/412]: Trying to find session by name auto-20150316-101519 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [311/412]: Created hashtable size 4 at 0x7d8c0 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG2 [311/412]: Setting trace directory path from URI to /home/root/lttng=
-traces/auto-20150316-101519 (in add_uri_to_consumer() at cmd.c:481)
DEBUG1 [311/412]: Sending response (size: 16, retcode: Success) (in thread_=
manage_clients() at main.c:3909)
DEBUG1 [311/412]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)

lttng enable-event -k -a

DEBUG1 [311/412]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [311/412]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [311/412]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [311/412]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [311/412]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [311/412]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [311/412]: Processing client command 7 (in process_client_msg() at m=
ain.c:2637)
DEBUG1 [311/412]: Getting session auto-20150316-101519 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [311/412]: Trying to find session by name auto-20150316-101519 (in s=
ession_find_by_name() at session.c:169)
DEBUG1 [311/412]: Creating kernel session (in create_kernel_session() at ma=
in.c:2553)
DEBUG3 [311/412]: Created hashtable size 4 at 0x76530 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG1 [311/412]: Kernel session created (fd: 30) (in kernel_create_session=
() at kernel.c:109)
DEBUG3 [311/412]: Copying tracing session consumer output in kernel session=
 (in copy_session_consumer() at main.c:2448)
DEBUG3 [311/412]: Created hashtable size 4 at 0x766d8 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [311/410]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at =
ht-cleanup.c:64)
DEBUG3 [311/412]: Copy session consumer subdir /kernel (in copy_session_con=
sumer() at main.c:2484)
DEBUG3 [311/412]: mkdir() recursive /home/root/lttng-traces/auto-20150316-1=
01519 with mode 504 for uid 0 and gid 0 (in run_as_mkdir_recursive() at run=
as.c:308)
DEBUG1 [311/412]: Using run_as_clone (in run_as() at runas.c:291)
DEBUG1 [311/412]: Spawning consumerd (in spawn_consumerd() at main.c:2158)
DEBUG2 [311/412]: Consumer pid 438 (in start_consumerd() at main.c:2340)
DEBUG2 [311/412]: Spawning consumer control thread (in start_consumerd() at=
 main.c:2343)
DEBUG3 [438/438]: Looking for a kernel consumer at these locations: (in spa=
wn_consumerd() at main.c:2177)
DEBUG3 [438/438]:       1)  (in spawn_consumerd() at main.c:2178)
DEBUG3 [438/438]:       2) /usr/lib/lttng/libexec/lttng-consumerd (in spawn=
_consumerd() at main.c:2179)
DEBUG3 [438/438]:       3) /usr/lib/lttng/libexec/lttng-consumerd (in spawn=
_consumerd() at main.c:2180)
DEBUG1 [311/439]: [thread] Manage consumer started (in thread_manage_consum=
er() at main.c:994)
DEBUG3 [438/438]: Found location #2 (in spawn_consumerd() at main.c:2185)
DEBUG1 [438/438]: Using kernel consumer at: /usr/lib/lttng/libexec/lttng-co=
nsumerd (in spawn_consumerd() at main.c:2195)
DEBUG2 [311/439]: Receiving code from consumer err_sock (in thread_manage_c=
onsumer() at main.c:1079)
Warning: No tracing group detected
DEBUG1 [311/439]: Consumer command socket ready (fd: 33 (in thread_manage_c=
onsumer() at main.c:1113)
DEBUG1 [311/439]: Consumer metadata socket ready (fd: 34) (in thread_manage=
_consumer() at main.c:1115)
DEBUG3 [311/412]: Consumer socket created (fd: 33) and added to output (in =
consumer_create_socket() at consumer.c:301)
DEBUG1 [311/412]: Setting relayd for session auto-20150316-101519 (in cmd_s=
etup_relayd() at cmd.c:722)
DEBUG1 [311/412]: Enabling all events (in process_client_msg() at main.c:30=
46)
DEBUG1 [311/412]: Trying to find channel channel0 (in trace_kernel_get_chan=
nel_by_name() at trace-kernel.c:48)
DEBUG1 [311/412]: Enabling channel  for session auto-20150316-101519 (in cm=
d_enable_channel() at cmd.c:910)
DEBUG1 [311/412]: Trying to find channel channel0 (in trace_kernel_get_chan=
nel_by_name() at trace-kernel.c:48)
DEBUG3 [311/412]: Kernel create channel  with attr: 0, 262144, 4, 0, 200000=
, 0, 0 (in kernel_create_channel() at kernel.c:143)
DEBUG1 [311/412]: Kernel channel channel0 created (fd: 35) (in kernel_creat=
e_channel() at kernel.c:165)
DEBUG1 [311/418]: Updating kernel poll set (in update_kernel_poll() at main=
.c:689)
DEBUG1 [311/412]: Kernel quiescent wait on 6 (in kernel_wait_quiescent() at=
 kernel.c:429)
DEBUG1 [311/412]: Trying to find channel channel0 (in trace_kernel_get_chan=
nel_by_name() at trace-kernel.c:48)
DEBUG1 [311/412]: Found channel by name channel0 (in trace_kernel_get_chann=
el_by_name() at trace-kernel.c:52)
DEBUG1 [311/412]: Reallocating event list from 64 to 128 bytes (in kernel_l=
ist_events() at kernel.c:644)
DEBUG1 [311/412]: Reallocating event list from 128 to 256 bytes (in kernel_=
list_events() at kernel.c:644)
DEBUG1 [311/412]: Reallocating event list from 256 to 512 bytes (in kernel_=
list_events() at kernel.c:644)
DEBUG1 [311/412]: Kernel list events done (292 events) (in kernel_list_even=
ts() at kernel.c:667)
DEBUG1 [311/412]: Event workqueue_queue_work created (fd: 36) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event workqueue_activate_work created (fd: 37) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event workqueue_execute_start created (fd: 38) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event workqueue_execute_end created (fd: 39) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_kswapd_sleep created (fd: 40) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_kswapd_wake created (fd: 41) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_wakeup_kswapd created (fd: 42) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_direct_reclaim_begin created (fd: 43) (in=
 kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_memcg_reclaim_begin created (fd: 44) (in =
kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_memcg_softlimit_reclaim_begin created (fd=
: 45) (in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_direct_reclaim_end created (fd: 46) (in k=
ernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_memcg_reclaim_end created (fd: 47) (in ke=
rnel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_memcg_softlimit_reclaim_end created (fd: =
48) (in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_shrink_slab_start created (fd: 49) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_shrink_slab_end created (fd: 50) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_lru_isolate created (fd: 51) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_memcg_isolate created (fd: 52) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_writepage created (fd: 53) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_vmscan_lru_shrink_inactive created (fd: 54) (in =
kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event udp_fail_queue_rcv_skb created (fd: 55) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event timer_init created (fd: 56) (in kernel_create_event=
() at kernel.c:236)
DEBUG1 [311/412]: Event timer_start created (fd: 57) (in kernel_create_even=
t() at kernel.c:236)
DEBUG1 [311/412]: Event timer_expire_entry created (fd: 58) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event timer_expire_exit created (fd: 59) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event timer_cancel created (fd: 60) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event hrtimer_init created (fd: 61) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event hrtimer_start created (fd: 62) (in kernel_create_ev=
ent() at kernel.c:236)
DEBUG1 [311/412]: Event hrtimer_expire_entry created (fd: 63) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event hrtimer_expire_exit created (fd: 64) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event hrtimer_cancel created (fd: 65) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event itimer_state created (fd: 66) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event itimer_expire created (fd: 67) (in kernel_create_ev=
ent() at kernel.c:236)
DEBUG1 [311/412]: Event rpc_call_status created (fd: 68) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event rpc_bind_status created (fd: 69) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event rpc_connect_status created (fd: 70) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event rpc_task_begin created (fd: 71) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event rpc_task_run_action created (fd: 72) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event rpc_task_complete created (fd: 73) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event rpc_task_sleep created (fd: 74) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event rpc_task_wakeup created (fd: 75) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event lttng_statedump_start created (fd: 76) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event lttng_statedump_end created (fd: 77) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event lttng_statedump_process_state created (fd: 78) (in =
kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event lttng_statedump_file_descriptor created (fd: 79) (i=
n kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event lttng_statedump_vm_map created (fd: 80) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event lttng_statedump_network_interface created (fd: 81) =
(in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event lttng_statedump_interrupt created (fd: 82) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event sock_rcvqueue_full created (fd: 83) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event sock_exceed_buf_limit created (fd: 84) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event skb_kfree created (fd: 85) (in kernel_create_event(=
) at kernel.c:236)
DEBUG1 [311/412]: Event skb_consume created (fd: 86) (in kernel_create_even=
t() at kernel.c:236)
DEBUG1 [311/412]: Event skb_copy_datagram_iovec created (fd: 87) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event signal_generate created (fd: 88) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event signal_deliver created (fd: 89) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event scsi_dispatch_cmd_start created (fd: 90) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event scsi_dispatch_cmd_error created (fd: 91) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event scsi_dispatch_cmd_done created (fd: 92) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event scsi_dispatch_cmd_timeout created (fd: 93) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event scsi_eh_wakeup created (fd: 94) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event sched_kthread_stop created (fd: 95) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_kthread_stop_ret created (fd: 96) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_wakeup created (fd: 97) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event sched_wakeup_new created (fd: 98) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_switch created (fd: 99) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event sched_migrate_task created (fd: 100) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_process_free created (fd: 101) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_process_exit created (fd: 102) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_wait_task created (fd: 103) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_process_wait created (fd: 104) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_process_fork created (fd: 105) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_process_exec created (fd: 106) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_stat_wait created (fd: 107) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_stat_sleep created (fd: 108) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_stat_iowait created (fd: 109) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_stat_blocked created (fd: 110) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_stat_runtime created (fd: 111) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event sched_pi_setprio created (fd: 112) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event regmap_reg_write created (fd: 113) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event regmap_reg_read created (fd: 114) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event regmap_reg_read_cache created (fd: 115) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event regmap_hw_read_start created (fd: 116) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event regmap_hw_read_done created (fd: 117) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event regmap_hw_write_start created (fd: 118) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event regmap_hw_write_done created (fd: 119) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event regcache_sync created (fd: 120) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event regmap_cache_only created (fd: 121) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event regmap_cache_bypass created (fd: 122) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event rcu_utilization created (fd: 123) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event random_mix_pool_bytes created (fd: 124) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event random_mix_pool_bytes_nolock created (fd: 125) (in =
kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event random_credit_entropy_bits created (fd: 126) (in ke=
rnel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event random_get_random_bytes created (fd: 127) (in kerne=
l_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event random_extract_entropy created (fd: 128) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event random_extract_entropy_user created (fd: 129) (in k=
ernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event console created (fd: 130) (in kernel_create_event()=
 at kernel.c:236)
DEBUG1 [311/412]: Event power_cpu_idle created (fd: 131) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event power_cpu_frequency created (fd: 132) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event power_machine_suspend created (fd: 133) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event power_wakeup_source_activate created (fd: 134) (in =
kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event power_wakeup_source_deactivate created (fd: 135) (i=
n kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event power_clock_enable created (fd: 136) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event power_clock_disable created (fd: 137) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event power_clock_set_rate created (fd: 138) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event power_domain_target created (fd: 139) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event net_dev_xmit created (fd: 140) (in kernel_create_ev=
ent() at kernel.c:236)
DEBUG1 [311/412]: Event net_dev_queue created (fd: 141) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event netif_receive_skb created (fd: 142) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event netif_rx created (fd: 143) (in kernel_create_event(=
) at kernel.c:236)
DEBUG1 [311/412]: Event napi_poll created (fd: 144) (in kernel_create_event=
() at kernel.c:236)
DEBUG1 [311/412]: Event module_load created (fd: 145) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event module_free created (fd: 146) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event module_get created (fd: 147) (in kernel_create_even=
t() at kernel.c:236)
DEBUG1 [311/412]: Event module_put created (fd: 148) (in kernel_create_even=
t() at kernel.c:236)
DEBUG1 [311/412]: Event module_request created (fd: 149) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event kmem_kmalloc created (fd: 150) (in kernel_create_ev=
ent() at kernel.c:236)
DEBUG1 [311/412]: Event kmem_cache_alloc created (fd: 151) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event kmem_kmalloc_node created (fd: 152) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event kmem_cache_alloc_node created (fd: 153) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event kmem_kfree created (fd: 154) (in kernel_create_even=
t() at kernel.c:236)
DEBUG1 [311/412]: Event kmem_cache_free created (fd: 155) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_page_free created (fd: 156) (in kernel_create_ev=
ent() at kernel.c:236)
DEBUG1 [311/412]: Event mm_page_free_batched created (fd: 157) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_page_alloc created (fd: 158) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event mm_page_alloc_zone_locked created (fd: 159) (in ker=
nel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_page_pcpu_drain created (fd: 160) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_page_alloc_extfrag created (fd: 161) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_checkpoint created (fd: 162) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_start_commit created (fd: 163) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_commit_locking created (fd: 164) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_commit_flushing created (fd: 165) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_commit_logging created (fd: 166) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_drop_transaction created (fd: 167) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_end_commit created (fd: 168) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_submit_inode_data created (fd: 169) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_run_stats created (fd: 170) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_checkpoint_stats created (fd: 171) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_update_log_tail created (fd: 172) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd2_write_superblock created (fd: 173) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_checkpoint created (fd: 174) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_start_commit created (fd: 175) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_commit_locking created (fd: 176) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_commit_flushing created (fd: 177) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_commit_logging created (fd: 178) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_drop_transaction created (fd: 179) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_end_commit created (fd: 180) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_do_submit_data created (fd: 181) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_cleanup_journal_tail created (fd: 182) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event jbd_journal_write_superblock created (fd: 183) (in =
kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event irq_handler_entry created (fd: 184) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event irq_handler_exit created (fd: 185) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event softirq_entry created (fd: 186) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event softirq_exit created (fd: 187) (in kernel_create_ev=
ent() at kernel.c:236)
DEBUG1 [311/412]: Event softirq_raise created (fd: 188) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event gpio_direction created (fd: 189) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event gpio_value created (fd: 190) (in kernel_create_even=
t() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_free_inode created (fd: 191) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_request_inode created (fd: 192) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_allocate_inode created (fd: 193) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_evict_inode created (fd: 194) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_drop_inode created (fd: 195) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mark_inode_dirty created (fd: 196) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_begin_ordered_truncate created (fd: 197) (in k=
ernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_write_begin created (fd: 198) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_da_write_begin created (fd: 199) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ordered_write_end created (fd: 200) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_writeback_write_end created (fd: 201) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_journalled_write_end created (fd: 202) (in ker=
nel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_da_write_end created (fd: 203) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_da_writepages created (fd: 204) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_da_write_pages created (fd: 205) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_da_writepages_result created (fd: 206) (in ker=
nel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_writepage created (fd: 207) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_readpage created (fd: 208) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_releasepage created (fd: 209) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_invalidatepage created (fd: 210) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_discard_blocks created (fd: 211) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mb_new_inode_pa created (fd: 212) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mb_new_group_pa created (fd: 213) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mb_release_inode_pa created (fd: 214) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mb_release_group_pa created (fd: 215) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_discard_preallocations created (fd: 216) (in k=
ernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mb_discard_preallocations created (fd: 217) (i=
n kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_request_blocks created (fd: 218) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_allocate_blocks created (fd: 219) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_free_blocks created (fd: 220) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_sync_file_enter created (fd: 221) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_sync_file_exit created (fd: 222) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_sync_fs created (fd: 223) (in kernel_create_ev=
ent() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_alloc_da_blocks created (fd: 224) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mballoc_alloc created (fd: 225) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mballoc_prealloc created (fd: 226) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mballoc_discard created (fd: 227) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mballoc_free created (fd: 228) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_forget created (fd: 229) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_da_update_reserve_space created (fd: 230) (in =
kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_da_reserve_space created (fd: 231) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_da_release_space created (fd: 232) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mb_bitmap_load created (fd: 233) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_mb_buddy_bitmap_load created (fd: 234) (in ker=
nel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_read_block_bitmap_load created (fd: 235) (in k=
ernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_load_inode_bitmap created (fd: 236) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_direct_IO_enter created (fd: 237) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_direct_IO_exit created (fd: 238) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_fallocate_enter created (fd: 239) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_fallocate_exit created (fd: 240) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_unlink_enter created (fd: 241) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_unlink_exit created (fd: 242) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_truncate_enter created (fd: 243) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_truncate_exit created (fd: 244) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_convert_to_initialized_enter created (fd: =
245) (in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_convert_to_initialized_fastpath created (f=
d: 246) (in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_map_blocks_enter created (fd: 247) (in ker=
nel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ind_map_blocks_enter created (fd: 248) (in ker=
nel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_map_blocks_exit created (fd: 249) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ind_map_blocks_exit created (fd: 250) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_load_extent created (fd: 251) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_load_inode created (fd: 252) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_journal_start created (fd: 253) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_trim_extent created (fd: 254) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_trim_all_free created (fd: 255) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_handle_uninitialized_extents created (fd: =
256) (in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_get_implied_cluster_alloc_exit created (fd: 25=
7) (in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_put_in_cache created (fd: 258) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_in_cache created (fd: 259) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_find_delalloc_range created (fd: 260) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_get_reserved_cluster_alloc created (fd: 261) (=
in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_show_extent created (fd: 262) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_remove_blocks created (fd: 263) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_rm_leaf created (fd: 264) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_rm_idx created (fd: 265) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_remove_space created (fd: 266) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext4_ext_remove_space_done created (fd: 267) (in ke=
rnel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_free_inode created (fd: 268) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_request_inode created (fd: 269) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_allocate_inode created (fd: 270) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_evict_inode created (fd: 271) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_drop_inode created (fd: 272) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_mark_inode_dirty created (fd: 273) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_write_begin created (fd: 274) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_ordered_write_end created (fd: 275) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_writeback_write_end created (fd: 276) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_journalled_write_end created (fd: 277) (in ker=
nel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_ordered_writepage created (fd: 278) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_writeback_writepage created (fd: 279) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_journalled_writepage created (fd: 280) (in ker=
nel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_readpage created (fd: 281) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_releasepage created (fd: 282) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_invalidatepage created (fd: 283) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_discard_blocks created (fd: 284) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_request_blocks created (fd: 285) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_allocate_blocks created (fd: 286) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_free_blocks created (fd: 287) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_sync_file_enter created (fd: 288) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_sync_file_exit created (fd: 289) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_sync_fs created (fd: 290) (in kernel_create_ev=
ent() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_rsv_window_add created (fd: 291) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_discard_reservation created (fd: 292) (in kern=
el_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_alloc_new_reservation created (fd: 293) (in ke=
rnel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_reserved created (fd: 294) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_forget created (fd: 295) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_read_block_bitmap created (fd: 296) (in kernel=
_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_direct_IO_enter created (fd: 297) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_direct_IO_exit created (fd: 298) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_unlink_enter created (fd: 299) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_unlink_exit created (fd: 300) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_truncate_enter created (fd: 301) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_truncate_exit created (fd: 302) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_get_blocks_enter created (fd: 303) (in kernel_=
create_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_get_blocks_exit created (fd: 304) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event ext3_load_inode created (fd: 305) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_compaction_isolate_migratepages created (fd: 306=
) (in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_compaction_isolate_freepages created (fd: 307) (=
in kernel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event mm_compaction_migratepages created (fd: 308) (in ke=
rnel_create_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_touch_buffer created (fd: 309) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_dirty_buffer created (fd: 310) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_rq_abort created (fd: 311) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event block_rq_requeue created (fd: 312) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_rq_complete created (fd: 313) (in kernel_crea=
te_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_rq_insert created (fd: 314) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_rq_issue created (fd: 315) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Event block_bio_bounce created (fd: 316) (in kernel_creat=
e_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_bio_complete created (fd: 317) (in kernel_cre=
ate_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_bio_backmerge created (fd: 318) (in kernel_cr=
eate_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_bio_frontmerge created (fd: 319) (in kernel_c=
reate_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_bio_queue created (fd: 320) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_getrq created (fd: 321) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event block_sleeprq created (fd: 322) (in kernel_create_e=
vent() at kernel.c:236)
DEBUG1 [311/412]: Event block_plug created (fd: 323) (in kernel_create_even=
t() at kernel.c:236)
DEBUG1 [311/412]: Event block_unplug created (fd: 324) (in kernel_create_ev=
ent() at kernel.c:236)
DEBUG1 [311/412]: Event block_split created (fd: 325) (in kernel_create_eve=
nt() at kernel.c:236)
DEBUG1 [311/412]: Event block_bio_remap created (fd: 326) (in kernel_create=
_event() at kernel.c:236)
DEBUG1 [311/412]: Event block_rq_remap created (fd: 327) (in kernel_create_=
event() at kernel.c:236)
DEBUG1 [311/412]: Enabling all syscall tracing (in event_kernel_enable_all_=
syscalls() at event.c:260)
DEBUG2 [311/412]: Kernel event syscall creation success (in kernel_create_e=
vent() at kernel.c:215)
DEBUG1 [311/412]: Event  created (fd: -1) (in kernel_create_event() at kern=
el.c:236)
DEBUG1 [311/412]: Kernel quiescent wait on 6 (in kernel_wait_quiescent() at=
 kernel.c:429)
DEBUG1 [311/412]: Sending response (size: 16, retcode: Success) (in thread_=
manage_clients() at main.c:3909)
DEBUG1 [311/418]: Channel fd 35 added to kernel set (in update_kernel_poll(=
) at main.c:707)
DEBUG1 [311/418]: Thread kernel polling on 3 fds (in thread_manage_kernel()=
 at main.c:874)
DEBUG1 [311/418]: Updating kernel streams for channel fd 35 (in update_kern=
el_stream() at main.c:733)
DEBUG1 [311/418]: Channel found, updating kernel streams (in update_kernel_=
stream() at main.c:746)
DEBUG1 [311/418]: Kernel stream channel0_0 created (fd: 328, state: 0) (in =
kernel_open_channel_stream() at kernel.c:562)
DEBUG1 [311/418]: Kernel stream channel0_1 created (fd: 329, state: 0) (in =
kernel_open_channel_stream() at kernel.c:562)
DEBUG1 [311/418]: Thread kernel polling on 3 fds (in thread_manage_kernel()=
 at main.c:874)
DEBUG1 [311/412]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)

lttng start

DEBUG1 [311/412]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [311/412]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [311/412]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [311/412]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [311/412]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [311/412]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [311/412]: Processing client command 16 (in process_client_msg() at =
main.c:2637)
DEBUG1 [311/412]: Getting session auto-20150316-101519 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [311/412]: Trying to find session by name auto-20150316-101519 (in s=
ession_find_by_name() at session.c:169)
DEBUG1 [311/412]: Kernel metadata opened (fd: 330) (in kernel_open_metadata=
() at kernel.c:389)
DEBUG1 [311/412]: Kernel metadata stream created (fd: 331) (in kernel_open_=
metadata_stream() at kernel.c:586)
DEBUG1 [311/412]: Sending session stream to kernel consumer (in kernel_cons=
umer_send_session() at kernel-consumer.c:374)
DEBUG1 [311/412]: Sending metadata 331 to kernel consumer (in kernel_consum=
er_add_metadata() at kernel-consumer.c:159)
DEBUG3 [311/412]: mkdir() recursive /home/root/lttng-traces/auto-20150316-1=
01519/kernel with mode 504 for uid 0 and gid 0 (in run_as_mkdir_recursive()=
 at runas.c:308)
DEBUG1 [311/412]: Using run_as_clone (in run_as() at runas.c:291)
DEBUG3 [311/412]: Kernel local consumer tracefile path: /home/root/lttng-tr=
aces/auto-20150316-101519/kernel (in create_channel_path() at kernel-consum=
er.c:60)
DEBUG1 [311/412]: Sending streams of channel channel0 to kernel consumer (i=
n kernel_consumer_send_channel_stream() at kernel-consumer.c:324)
DEBUG1 [311/412]: Kernel consumer adding channel channel0 to kernel consume=
r (in kernel_consumer_add_channel() at kernel-consumer.c:98)
DEBUG3 [311/412]: mkdir() recursive /home/root/lttng-traces/auto-20150316-1=
01519/kernel with mode 504 for uid 0 and gid 0 (in run_as_mkdir_recursive()=
 at runas.c:308)
DEBUG1 [311/412]: Using run_as_clone (in run_as() at runas.c:291)
DEBUG3 [311/412]: Kernel local consumer tracefile path: /home/root/lttng-tr=
aces/auto-20150316-101519/kernel (in create_channel_path() at kernel-consum=
er.c:60)
DEBUG1 [311/412]: Sending stream 329 of channel channel0 to kernel consumer=
 (in kernel_consumer_add_stream() at kernel-consumer.c:241)
DEBUG1 [311/412]: Sending stream 328 of channel channel0 to kernel consumer=
 (in kernel_consumer_add_stream() at kernel-consumer.c:241)
DEBUG1 [311/412]: Sending streams_sent (in kernel_consumer_streams_sent() a=
t kernel-consumer.c:280)
DEBUG1 [311/412]: Kernel consumer FDs of metadata and channel streams sent =
(in kernel_consumer_send_session() at kernel-consumer.c:402)
DEBUG1 [311/412]: Kernel session started (in kernel_start_session() at kern=
el.c:414)
DEBUG1 [311/412]: Kernel quiescent wait on 6 (in kernel_wait_quiescent() at=
 kernel.c:429)
DEBUG1 [311/412]: Sending response (size: 16, retcode: Success) (in thread_=
manage_clients() at main.c:3909)
DEBUG1 [311/412]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
PERROR [438/443]: kernctl_get_timestamp_begin: Inappropriate ioctl for devi=
ce (in get_index_values() at kernel-consumer.c:973)

lttng stop

DEBUG1 [311/412]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [311/412]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [311/412]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [311/412]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [311/412]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [311/412]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [311/412]: Processing client command 17 (in process_client_msg() at =
main.c:2637)
DEBUG1 [311/412]: Getting session auto-20150316-101519 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [311/412]: Trying to find session by name auto-20150316-101519 (in s=
ession_find_by_name() at session.c:169)
DEBUG1 [311/412]: Stop kernel tracing (in cmd_stop_trace() at cmd.c:1879)
DEBUG1 [311/412]: Kernel flushing metadata buffer on fd 331 (in kernel_meta=
data_flush_buffer() at kernel.c:464)
DEBUG1 [311/412]: Flush buffer for channel channel0 (in kernel_flush_buffer=
() at kernel.c:484)
DEBUG1 [311/412]: Flushing channel stream 329 (in kernel_flush_buffer() at =
kernel.c:487)
DEBUG1 [311/412]: Flushing channel stream 328 (in kernel_flush_buffer() at =
kernel.c:487)
DEBUG1 [311/412]: Kernel session stopped (in kernel_stop_session() at kerne=
l.c:513)
DEBUG1 [311/412]: Kernel quiescent wait on 6 (in kernel_wait_quiescent() at=
 kernel.c:429)
DEBUG1 [311/412]: Sending response (size: 16, retcode: Success) (in thread_=
manage_clients() at main.c:3909)
DEBUG1 [311/412]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [311/412]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [311/412]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [311/412]: Processing client command 24 (in process_client_msg() at =
main.c:2637)
DEBUG1 [311/412]: Getting session auto-20150316-101519 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [311/412]: Trying to find session by name auto-20150316-101519 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [311/412]: Consumer data pending for id 0 (in consumer_is_data_pendi=
ng() at consumer.c:1083)
DEBUG1 [311/412]: Consumer data is NOT pending for session id 0 (in consume=
r_is_data_pending() at consumer.c:1119)
DEBUG1 [311/412]: Sending response (size: 16, retcode: Unknown error code) =
(in thread_manage_clients() at main.c:3909)
DEBUG1 [311/412]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [311/412]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)

Here are the contents of the lttng-traces directories after stopping the tr=
acing:

root@socfpga_cyclone5:~# ls -Rl
.:
drwxrwx---    3 root     root          4096 Mar 16 10:15 lttng-traces

./lttng-traces:
drwxrwx---    3 root     root          4096 Mar 16 10:16 auto-20150316-1015=
19

./lttng-traces/auto-20150316-101519:
drwxrwx---    3 root     root          4096 Mar 16 10:16 kernel

./lttng-traces/auto-20150316-101519/kernel:
-rw-rw----    1 root     root             0 Mar 16 10:16 channel0_0
-rw-rw----    1 root     root             0 Mar 16 10:16 channel0_1
drwxrwx---    2 root     root          4096 Mar 16 10:16 index
-rw-rw----    1 root     root        221184 Mar 16 10:16 metadata

./lttng-traces/auto-20150316-101519/kernel/index:
-rw-rw----    1 root     root            16 Mar 16 10:16 channel0_0.idx
-rw-rw----    1 root     root            16 Mar 16 10:16 channel0_1.idx

Notice zero-length for kernel/channel0_0 and kernel/channel0_1.

What distribution are you on?

The kernel-version is:

Linux socfpga_cyclone5 3.10.31-ltsi-05082-g018fe6c #1 SMP Fri Mar 13 16:38:=
52 GMT 2015 armv7l GNU/Linux

Lttng version is:

root@socfpga_cyclone5:~# lttng --version
lttng (LTTng Trace Control) 2.4.0 - =C9poque Opaque

I am using this version because it is the version included as a recipe in t=
he Yocto Daisy distribution for the Altera SoCFPGA.
As I am five hours or so in front of you guys, I shall try and get a build =
working with the latest version of LTTng (2.6.0), but I am not a bitbake/yo=
cto expert
And each time I try to change something, I end up with a whole raft of new =
problems to solve.

Thanks again,

Neil.

On 2015-03-13 12:40 PM, Neil Bryan wrote:
>
> Hello,
>
> When I create a session and try to capture some kernel traces I see =

> the following (first output from lttng-sessiond and then from the =

> tracing session):
>
>
> I am using the following version of LTTng:
>
> nbryan@meteor:/data/nbryan/Meteor/YoctoDaisy/poky/meta/recipes-kernel/
> lttng$
> ls -1
>
> babeltrace_1.1.1.bb
>
> lttng-modules
>
> lttng-modules_2.3.3.bb
>
> lttng-modules_2.4.2.bb
>
> lttng-tools
>
> lttng-tools_2.3.1.bb
>
> lttng-tools_2.4.0.bb
>
> lttng-ust
>
> lttng-ust_2.3.1.bb
>
> lttng-ust_2.4.0.bb
>
> Thank you for any clues,
>
>
> Regards,
>
> Neil.
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Jonathan R. Julien
Efficios
