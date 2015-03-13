From: Neil Bryan <Neil.Bryan@ttp.com>
Subject: Inappropriate ioctl for device error
Date: Fri, 13 Mar 2015 16:40:36 +0000
Message-ID: <8369DAE2C5B8814998E89CE414A915381F6BA2BF__23890.3545345694$1426264948$gmane$org@IT-Mailbox3.TTPGroup.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0827861495=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.106])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Neil.Bryan@ttp.com>) id 1YWSdd-0003Lj-6b
 for lttng-dev@lists.lttng.org; Fri, 13 Mar 2015 12:40:51 -0400
Content-Language: en-US
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

--===============0827861495==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_8369DAE2C5B8814998E89CE414A915381F6BA2BFITMailbox3TTPGr_"

--_000_8369DAE2C5B8814998E89CE414A915381F6BA2BFITMailbox3TTPGr_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

When I create a session and try to capture some kernel traces I see the fol=
lowing (first output from lttng-sessiond and then from the tracing session)=
:

root@socfpga_cyclone5:~# lttng-sessiond -vvv
DEBUG3 [300/300]: Creating LTTng run directory: /var/run/lttng (in create_l=
ttng_rundir() at main.c:4297)
DEBUG2 [300/300]: Kernel consumer err path: /var/run/lttng/kconsumerd/error=
 (in main() at main.c:4638)
DEBUG2 [300/300]: Kernel consumer cmd path: /var/run/lttng/kconsumerd/comma=
nd (in main() at main.c:4640)
DEBUG1 [300/300]: Client socket path /var/run/lttng/client-lttng-sessiond (=
in main() at main.c:4693)
DEBUG1 [300/300]: Application socket path /var/run/lttng/lttng-ust-sock-5 (=
in main() at main.c:4694)
DEBUG1 [300/300]: Application wait path /lttng-ust-wait-5 (in main() at mai=
n.c:4695)
DEBUG1 [300/300]: LTTng run directory path: /var/run/lttng (in main() at ma=
in.c:4696)
DEBUG2 [300/300]: UST consumer 32 bits err path: /var/run/lttng/ustconsumer=
d32/error (in main() at main.c:4705)
DEBUG2 [300/300]: UST consumer 32 bits cmd path: /var/run/lttng/ustconsumer=
d32/command (in main() at main.c:4707)
DEBUG2 [300/300]: UST consumer 64 bits err path: /var/run/lttng/ustconsumer=
d64/error (in main() at main.c:4716)
DEBUG2 [300/300]: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumer=
d64/command (in main() at main.c:4718)
DEBUG3 [300/300]: Created hashtable size 4 at 0x71080 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [300/300]: Created hashtable size 4 at 0x711f0 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [300/300]: Created hashtable size 4 at 0x71398 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [300/300]: Created hashtable size 4 at 0x71540 of type 1 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG2 [300/300]: Creating consumer directory: /var/run/lttng/kconsumerd (i=
n set_consumer_sockets() at main.c:4339)
Warning: No tracing group detected
DEBUG1 [300/300]: Modprobe successfully lttng-tracer (in modprobe_lttng_con=
trol() at modprobe.c:192)
DEBUG2 [300/300]: Kernel tracer version validated (major version 2) (in ker=
nel_validate_version() at kernel.c:704)
DEBUG1 [300/300]: Modprobe successfully lttng-ftrace (in modprobe_lttng_dat=
a() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-kprobes (in modprobe_lttng_da=
ta() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-kretprobes (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-lib-ring-buffer (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-client-discard (i=
n modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-client-overwrite =
(in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-metadata-client (=
in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-client-mmap-disca=
rd (in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-client-mmap-overw=
rite (in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-metadata-mmap-cli=
ent (in modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-types (in modprobe_lttng_data=
() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-asoc (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-block (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-btrfs (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-compaction (in modprobe=
_lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-ext3 (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-ext4 (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-gpio (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-irq (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-jbd (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-jbd2 (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-kmem (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-kvm (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-kvm-x86 (in modprobe_lt=
tng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-kvm-x86-mmu (in modprob=
e_lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-lock (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-module (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-napi (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-net (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-power (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-printk (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-random (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-rcu (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-regmap (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-regulator (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-rpm (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-sched (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-scsi (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-signal (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-skb (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-sock (in modprobe_lttng=
_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-statedump (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-sunrpc (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-timer (in modprobe_lttn=
g_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-udp (in modprobe_lttng_=
data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-vmscan (in modprobe_ltt=
ng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-workqueue (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Modprobe successfully lttng-probe-writeback (in modprobe_=
lttng_data() at modprobe.c:228)
DEBUG1 [300/300]: Kernel tracer fd 6 (in init_kernel_tracer() at main.c:239=
8)
DEBUG2 [300/300]: Creating consumer directory: /var/run/lttng/ustconsumerd6=
4 (in set_consumer_sockets() at main.c:4339)
DEBUG2 [300/300]: Creating consumer directory: /var/run/lttng/ustconsumerd3=
2 (in set_consumer_sockets() at main.c:4339)
DEBUG3 [300/300]: Session daemon client socket 9 and application socket 10 =
created (in init_daemon_socket() at main.c:4205)
DEBUG1 [300/300]: All permissions are set (in set_permissions() at main.c:4=
285)
DEBUG3 [300/300]: Created hashtable size 4 at 0x726e0 of type 2 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [300/300]: Global buffer per UID registry initialized (in buffer_reg=
_init_uid_registry() at buffer-registry.c:99)
DEBUG3 [300/300]: Created hashtable size 4 at 0x72868 of type 2 (in lttng_h=
t_new() at hashtable.c:127)
DEBUG3 [300/300]: Global buffer per PID registry initialized (in buffer_reg=
_init_pid_registry() at buffer-registry.c:220)
DEBUG1 [300/300]: epoll set max size is 89088 (in compat_epoll_set_max_size=
() at compat-epoll.c:290)
DEBUG1 [300/300]: Command subsystem initialized (in cmd_init() at cmd.c:311=
0)
DEBUG1 [300/300]: Pid 300 written in file /var/run/lttng/lttng-sessiond.pid=
 (in utils_create_pid_file() at utils.c:465)
DEBUG1 [300/300]: Pid 5345 written in file /var/run/lttng/jul.port (in util=
s_create_pid_file() at utils.c:465)
DEBUG1 [300/300]: TCP inet operation timeout set to 216 sec (in lttcomm_ine=
t_init() at inet.c:529)
DEBUG1 [300/300]: Health check time delta in seconds set to 236 (in health_=
init() at health.c:73)
DEBUG1 [300/399]: [ht-thread] startup. (in thread_ht_cleanup() at ht-cleanu=
p.c:36)
DEBUG1 [300/401]: [thread] Manage client started (in thread_manage_clients(=
) at main.c:3731)
DEBUG3 [300/399]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at =
ht-cleanup.c:64)
DEBUG1 [300/400]: [thread] Manage health check started (in thread_manage_he=
alth() at main.c:3545)
DEBUG1 [300/402]: [thread] Dispatch UST command started (in thread_dispatch=
_ust_registration() at main.c:1577)
DEBUG1 [300/404]: [thread] Manage application started (in thread_manage_app=
s() at main.c:1291)
DEBUG1 [300/402]: Futex n to 1 prepare done (in futex_nto1_prepare() at fut=
ex.c:75)
DEBUG1 [300/402]: Woken up but nothing in the UST command queue (in thread_=
dispatch_ust_registration() at main.c:1600)
DEBUG1 [300/404]: Apps thread polling on 2 fds (in thread_manage_apps() at =
main.c:1321)
DEBUG1 [300/403]: [thread] Manage application registration started (in thre=
ad_registration_apps() at main.c:1801)
DEBUG1 [300/405]: [ust-thread] Manage application notify command (in ust_th=
read_manage_notify() at ust-thread.c:39)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG3 [300/405]: [ust-thread] Manage notify polling on 2 fds (in ust_threa=
d_manage_notify() at ust-thread.c:68)
DEBUG1 [300/406]: [jul-thread] Manage JUL application registration. (in jul=
_thread_manage_registration() at jul-thread.c:258)
DEBUG1 [300/400]: Health check ready (in thread_manage_health() at main.c:3=
610)
DEBUG3 [300/406]: URI string: tcp://localhost (in uri_parse() at uri.c:291)
DEBUG1 [300/403]: Notifying applications of session daemon state: 1 (in not=
ify_ust_apps() at main.c:628)
DEBUG1 [300/403]: Got the wait shm fd 28 (in get_wait_shm() at shm.c:115)
DEBUG1 [300/403]: Futex wait update active 1 (in futex_wait_update() at fut=
ex.c:63)
DEBUG1 [300/403]: Accepting application registration (in thread_registratio=
n_apps() at main.c:1838)
DEBUG1 [300/407]: [thread] Thread manage kernel started (in thread_manage_k=
ernel() at main.c:829)
DEBUG1 [300/407]: Updating kernel poll set (in update_kernel_poll() at main=
.c:689)
DEBUG1 [300/407]: Thread kernel polling on 2 fds (in thread_manage_kernel()=
 at main.c:874)
DEBUG2 [300/406]: IP address resolved to 127.0.0.1 (in set_ip_address() at =
uri.c:132)
DEBUG3 [300/406]: URI dtype: 1, proto: 1, host: localhost, subdir: , ctrl: =
0, data: 0 (in uri_parse() at uri.c:505)
DEBUG1 [300/406]: [jul-thread] Listening on TCP port 5345 and socket 27 (in=
 init_tcp_socket() at jul-thread.c:156)
DEBUG3 [300/406]: [jul-thread] Manage JUL polling on 2 fds (in jul_thread_m=
anage_registration() at jul-thread.c:286)

libphy: stmmac-1:01 - Link is Down
libphy: stmmac-1:01 - Link is Up - 1000/Full
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 8 (in process_client_msg() at m=
ain.c:2637)
DEBUG1 [300/401]: Waiting for 1 URIs from client ... (in process_client_msg=
() at main.c:3201)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151645 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [300/401]: Created hashtable size 4 at 0x74105a68 of type 1 (in lttn=
g_ht_new() at hashtable.c:127)
DEBUG1 [300/401]: Tracing session auto-20150313-151645 created with ID 0 by=
 UID 0 GID 0 (in session_create() at session.c:276)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151645 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [300/401]: Created hashtable size 4 at 0x7410ac50 of type 1 (in lttn=
g_ht_new() at hashtable.c:127)
DEBUG2 [300/401]: Setting trace directory path from URI to /home/root/lttng=
-traces/auto-20150313-151645 (in add_uri_to_consumer() at cmd.c:481)
DEBUG1 [300/401]: Sending response (size: 16, retcode: Success) (in thread_=
manage_clients() at main.c:3909)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 16 (in process_client_msg() at =
main.c:2637)
DEBUG1 [300/401]: Getting session auto-20150313-151645 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151645 (in s=
ession_find_by_name() at session.c:169)
DEBUG1 [300/401]: Sending response (size: 16, retcode: No channel found in =
the session) (in thread_manage_clients() at main.c:3909)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 17 (in process_client_msg() at =
main.c:2637)
DEBUG1 [300/401]: Getting session auto-20150313-151645 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151645 (in s=
ession_find_by_name() at session.c:169)
DEBUG1 [300/401]: Sending response (size: 16, retcode: Tracing already stop=
ped) (in thread_manage_clients() at main.c:3909)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 24 (in process_client_msg() at =
main.c:2637)
DEBUG1 [300/401]: Getting session auto-20150313-151645 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151645 (in s=
ession_find_by_name() at session.c:169)
DEBUG1 [300/401]: Sending response (size: 16, retcode: Unknown error code) =
(in thread_manage_clients() at main.c:3909)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 9 (in process_client_msg() at m=
ain.c:2637)
DEBUG1 [300/401]: Getting session auto-20150313-151645 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151645 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [300/401]: No kernel session when tearing down session (in kernel_de=
stroy_session() at kernel.c:755)
DEBUG1 [300/401]: Destroying session auto-20150313-151645 (in session_destr=
oy() at session.c:194)
DEBUG1 [300/401]: Sending response (size: 16, retcode: Success) (in thread_=
manage_clients() at main.c:3909)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/407]: Updating kernel poll set (in update_kernel_poll() at main=
.c:689)
DEBUG1 [300/407]: Thread kernel polling on 2 fds (in thread_manage_kernel()=
 at main.c:874)
DEBUG3 [300/399]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at =
ht-cleanup.c:64)
DEBUG3 [300/399]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at =
ht-cleanup.c:64)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 8 (in process_client_msg() at m=
ain.c:2637)
DEBUG1 [300/401]: Waiting for 1 URIs from client ... (in process_client_msg=
() at main.c:3201)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151806 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [300/401]: Created hashtable size 4 at 0x74105a68 of type 1 (in lttn=
g_ht_new() at hashtable.c:127)
DEBUG1 [300/401]: Tracing session auto-20150313-151806 created with ID 1 by=
 UID 0 GID 0 (in session_create() at session.c:276)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151806 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [300/401]: Created hashtable size 4 at 0x7410ac50 of type 1 (in lttn=
g_ht_new() at hashtable.c:127)
DEBUG2 [300/401]: Setting trace directory path from URI to /home/root/lttng=
-traces/auto-20150313-151806 (in add_uri_to_consumer() at cmd.c:481)
DEBUG1 [300/401]: Sending response (size: 16, retcode: Success) (in thread_=
manage_clients() at main.c:3909)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 16 (in process_client_msg() at =
main.c:2637)
DEBUG1 [300/401]: Getting session auto-20150313-151806 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151806 (in s=
ession_find_by_name() at session.c:169)
DEBUG1 [300/401]: Sending response (size: 16, retcode: No channel found in =
the session) (in thread_manage_clients() at main.c:3909)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 17 (in process_client_msg() at =
main.c:2637)
DEBUG1 [300/401]: Getting session auto-20150313-151806 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151806 (in s=
ession_find_by_name() at session.c:169)
DEBUG1 [300/401]: Sending response (size: 16, retcode: Tracing already stop=
ped) (in thread_manage_clients() at main.c:3909)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 24 (in process_client_msg() at =
main.c:2637)
DEBUG1 [300/401]: Getting session auto-20150313-151806 by name (in process_=
client_msg() at main.c:2716)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-151806 (in s=
ession_find_by_name() at session.c:169)
DEBUG1 [300/401]: Sending response (size: 16, retcode: Unknown error code) =
(in thread_manage_clients() at main.c:3909)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Nothing recv() from client... continuing (in thread_manag=
e_clients() at main.c:3864)
DEBUG1 [300/401]: Clean command context structure (in clean_command_ctx() a=
t main.c:608)
DEBUG1 [300/401]: Accepting client command ... (in thread_manage_clients() =
at main.c:3773)
DEBUG1 [300/401]: Wait for client response (in thread_manage_clients() at m=
ain.c:3815)
DEBUG1 [300/401]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:3860)
DEBUG1 [300/401]: Processing client command 8 (in process_client_msg() at m=
ain.c:2637)
DEBUG1 [300/401]: Waiting for 1 URIs from client ... (in process_client_msg=
() at main.c:3201)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-152018 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [300/401]: Created hashtable size 4 at 0x7410afc8 of type 1 (in lttn=
g_ht_new() at hashtable.c:127)
DEBUG1 [300/401]: Tracing session auto-20150313-152018 created with ID 2 by=
 UID 0 GID 0 (in session_create() at session.c:276)
DEBUG2 [300/401]: Trying to find session by name auto-20150313-152018 (in s=
ession_find_by_name() at session.c:169)
DEBUG3 [300/401]: Created hashtable size 4 at 0x741101b0 of type 1 (in lttn=
g_ht_new() at hashtable.c:127)
DEBUG2 [300/401]: Setting trace directory path from URI to /home/root/lttng=
-traces/auto-20150313-152018 (in add_uri_to_consumer() at cmd.c:481)

Here is the session:

root@socfpga_cyclone5:~# lttng start
PERROR [528/533]: kernctl_get_timestamp_begin: Inappropriate ioctl for devi=
ce (in get_index_values() at kernel-consumer.c:973)
Tracing started for session auto-20150313-151441
root@socfpga_cyclone5:~# PERROR [528/533]: kernctl_get_timestamp_begin: Ina=
ppropriate ioctl for device (in get_index_values() at kernel-consumer.c:973=
)

root@socfpga_cyclone5:~# lttng stop
Waiting for data availability
Tracing stopped for session auto-20150313-151441

root@socfpga_cyclone5:~# ls -Rl
.:
drwxrwx---    3 root     root          4096 Mar 13 15:14 lttng-traces

./lttng-traces:
drwxrwx---    3 root     root          4096 Mar 13 15:14 auto-20150313-1514=
41

./lttng-traces/auto-20150313-151441:
drwxrwx---    3 root     root          4096 Mar 13 15:14 kernel

./lttng-traces/auto-20150313-151441/kernel:
-rw-rw----    1 root     root             0 Mar 13 15:14 channel0_0
-rw-rw----    1 root     root             0 Mar 13 15:14 channel0_1
drwxrwx---    2 root     root          4096 Mar 13 15:14 index
-rw-rw----    1 root     root        221184 Mar 13 15:14 metadata

./lttng-traces/auto-20150313-151441/kernel/index:
-rw-rw----    1 root     root            16 Mar 13 15:14 channel0_0.idx
-rw-rw----    1 root     root            16 Mar 13 15:14 channel0_1.idx

I am using the following version of LTTng:

nbryan@meteor:/data/nbryan/Meteor/YoctoDaisy/poky/meta/recipes-kernel/lttng=
$ ls -1
babeltrace_1.1.1.bb
lttng-modules
lttng-modules_2.3.3.bb
lttng-modules_2.4.2.bb
lttng-tools
lttng-tools_2.3.1.bb
lttng-tools_2.4.0.bb
lttng-ust
lttng-ust_2.3.1.bb
lttng-ust_2.4.0.bb

Thank you for any clues,

Regards,

Neil.

--_000_8369DAE2C5B8814998E89CE414A915381F6BA2BFITMailbox3TTPGr_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:2.0cm 42.5pt 2.0cm 3.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When I create a session and try to capture some kern=
el traces I see the following (first output from lttng-sessiond and then fr=
om the tracing session):<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">root@socfpga_cyclone5:~# lttng-sessiond -vvv<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Creating LTTng run directory: /var/run/lt=
tng (in create_lttng_rundir() at main.c:4297)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: Kernel consumer err path: /var/run/lttng/=
kconsumerd/error (in main() at main.c:4638)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: Kernel consumer cmd path: /var/run/lttng/=
kconsumerd/command (in main() at main.c:4640)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Client socket path /var/run/lttng/client-=
lttng-sessiond (in main() at main.c:4693)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Application socket path /var/run/lttng/lt=
tng-ust-sock-5 (in main() at main.c:4694)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Application wait path /lttng-ust-wait-5 (=
in main() at main.c:4695)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: LTTng run directory path: /var/run/lttng =
(in main() at main.c:4696)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: UST consumer 32 bits err path: /var/run/l=
ttng/ustconsumerd32/error (in main() at main.c:4705)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: UST consumer 32 bits cmd path: /var/run/l=
ttng/ustconsumerd32/command (in main() at main.c:4707)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: UST consumer 64 bits err path: /var/run/l=
ttng/ustconsumerd64/error (in main() at main.c:4716)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: UST consumer 64 bits cmd path: /var/run/l=
ttng/ustconsumerd64/command (in main() at main.c:4718)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Created hashtable size 4 at 0x71080 of ty=
pe 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Created hashtable size 4 at 0x711f0 of ty=
pe 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Created hashtable size 4 at 0x71398 of ty=
pe 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Created hashtable size 4 at 0x71540 of ty=
pe 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: Creating consumer directory: /var/run/ltt=
ng/kconsumerd (in set_consumer_sockets() at main.c:4339)<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">Warning: No tracing group detected<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-tracer (in mo=
dprobe_lttng_control() at modprobe.c:192)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: Kernel tracer version validated (major ve=
rsion 2) (in kernel_validate_version() at kernel.c:704)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-ftrace (in mo=
dprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-kprobes (in m=
odprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-kretprobes (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-lib-ring-buff=
er (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-c=
lient-discard (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-c=
lient-overwrite (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-m=
etadata-client (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-c=
lient-mmap-discard (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-c=
lient-mmap-overwrite (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-ring-buffer-m=
etadata-mmap-client (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-types (in mod=
probe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-asoc (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-block (=
in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-btrfs (=
in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-compact=
ion (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-ext3 (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-ext4 (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-gpio (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-irq (in=
 modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-jbd (in=
 modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-jbd2 (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-kmem (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-kvm (in=
 modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-kvm-x86=
 (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-kvm-x86=
-mmu (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-lock (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-module =
(in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-napi (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-net (in=
 modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-power (=
in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-printk =
(in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-random =
(in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-rcu (in=
 modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-regmap =
(in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-regulat=
or (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-rpm (in=
 modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-sched (=
in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-scsi (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-signal =
(in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-skb (in=
 modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-sock (i=
n modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-statedu=
mp (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-sunrpc =
(in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-timer (=
in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-udp (in=
 modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-vmscan =
(in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-workque=
ue (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Modprobe successfully lttng-probe-writeba=
ck (in modprobe_lttng_data() at modprobe.c:228)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Kernel tracer fd 6 (in init_kernel_tracer=
() at main.c:2398)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: Creating consumer directory: /var/run/ltt=
ng/ustconsumerd64 (in set_consumer_sockets() at main.c:4339)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/300]: Creating consumer directory: /var/run/ltt=
ng/ustconsumerd32 (in set_consumer_sockets() at main.c:4339)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Session daemon client socket 9 and applic=
ation socket 10 created (in init_daemon_socket() at main.c:4205)<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: All permissions are set (in set_permissio=
ns() at main.c:4285)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Created hashtable size 4 at 0x726e0 of ty=
pe 2 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Global buffer per UID registry initialize=
d (in buffer_reg_init_uid_registry() at buffer-registry.c:99)<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Created hashtable size 4 at 0x72868 of ty=
pe 2 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/300]: Global buffer per PID registry initialize=
d (in buffer_reg_init_pid_registry() at buffer-registry.c:220)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: epoll set max size is 89088 (in compat_ep=
oll_set_max_size() at compat-epoll.c:290)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Command subsystem initialized (in cmd_ini=
t() at cmd.c:3110)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Pid 300 written in file /var/run/lttng/lt=
tng-sessiond.pid (in utils_create_pid_file() at utils.c:465)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Pid 5345 written in file /var/run/lttng/j=
ul.port (in utils_create_pid_file() at utils.c:465)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: TCP inet operation timeout set to 216 sec=
 (in lttcomm_inet_init() at inet.c:529)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/300]: Health check time delta in seconds set to=
 236 (in health_init() at health.c:73)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/399]: [ht-thread] startup. (in thread_ht_cleanu=
p() at ht-cleanup.c:36)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: [thread] Manage client started (in thread=
_manage_clients() at main.c:3731)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/399]: [ht-thread] Polling on 2 fds. (in thread_=
ht_cleanup() at ht-cleanup.c:64)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/400]: [thread] Manage health check started (in =
thread_manage_health() at main.c:3545)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/402]: [thread] Dispatch UST command started (in=
 thread_dispatch_ust_registration() at main.c:1577)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/404]: [thread] Manage application started (in t=
hread_manage_apps() at main.c:1291)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/402]: Futex n to 1 prepare done (in futex_nto1_=
prepare() at futex.c:75)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/402]: Woken up but nothing in the UST command q=
ueue (in thread_dispatch_ust_registration() at main.c:1600)<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/404]: Apps thread polling on 2 fds (in thread_m=
anage_apps() at main.c:1321)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/403]: [thread] Manage application registration =
started (in thread_registration_apps() at main.c:1801)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/405]: [ust-thread] Manage application notify co=
mmand (in ust_thread_manage_notify() at ust-thread.c:39)<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/405]: [ust-thread] Manage notify polling on 2 f=
ds (in ust_thread_manage_notify() at ust-thread.c:68)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/406]: [jul-thread] Manage JUL application regis=
tration. (in jul_thread_manage_registration() at jul-thread.c:258)<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/400]: Health check ready (in thread_manage_heal=
th() at main.c:3610)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/406]: URI string: tcp://localhost (in uri_parse=
() at uri.c:291)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/403]: Notifying applications of session daemon =
state: 1 (in notify_ust_apps() at main.c:628)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/403]: Got the wait shm fd 28 (in get_wait_shm()=
 at shm.c:115)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/403]: Futex wait update active 1 (in futex_wait=
_update() at futex.c:63)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/403]: Accepting application registration (in th=
read_registration_apps() at main.c:1838)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/407]: [thread] Thread manage kernel started (in=
 thread_manage_kernel() at main.c:829)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/407]: Updating kernel poll set (in update_kerne=
l_poll() at main.c:689)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/407]: Thread kernel polling on 2 fds (in thread=
_manage_kernel() at main.c:874)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/406]: IP address resolved to 127.0.0.1 (in set_=
ip_address() at uri.c:132)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/406]: URI dtype: 1, proto: 1, host: localhost, =
subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:505)<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/406]: [jul-thread] Listening on TCP port 5345 a=
nd socket 27 (in init_tcp_socket() at jul-thread.c:156)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/406]: [jul-thread] Manage JUL polling on 2 fds =
(in jul_thread_manage_registration() at jul-thread.c:286)<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">libphy: stmmac-1:01 - Link is Down<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">libphy: stmmac-1:01 - Link is Up - 1000/Full<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 8 (in process_c=
lient_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Waiting for 1 URIs from client ... (in pr=
ocess_client_msg() at main.c:3201)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151645 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/401]: Created hashtable size 4 at 0x74105a68 of=
 type 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Tracing session auto-20150313-151645 crea=
ted with ID 0 by UID 0 GID 0 (in session_create() at session.c:276)<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151645 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/401]: Created hashtable size 4 at 0x7410ac50 of=
 type 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Setting trace directory path from URI to =
/home/root/lttng-traces/auto-20150313-151645 (in add_uri_to_consumer() at c=
md.c:481)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Sending response (size: 16, retcode: Succ=
ess) (in thread_manage_clients() at main.c:3909)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 16 (in process_=
client_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Getting session auto-20150313-151645 by n=
ame (in process_client_msg() at main.c:2716)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151645 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Sending response (size: 16, retcode: No c=
hannel found in the session) (in thread_manage_clients() at main.c:3909)<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 17 (in process_=
client_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Getting session auto-20150313-151645 by n=
ame (in process_client_msg() at main.c:2716)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151645 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Sending response (size: 16, retcode: Trac=
ing already stopped) (in thread_manage_clients() at main.c:3909)<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 24 (in process_=
client_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Getting session auto-20150313-151645 by n=
ame (in process_client_msg() at main.c:2716)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151645 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Sending response (size: 16, retcode: Unkn=
own error code) (in thread_manage_clients() at main.c:3909)<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 9 (in process_c=
lient_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Getting session auto-20150313-151645 by n=
ame (in process_client_msg() at main.c:2716)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151645 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/401]: No kernel session when tearing down sessi=
on (in kernel_destroy_session() at kernel.c:755)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Destroying session auto-20150313-151645 (=
in session_destroy() at session.c:194)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Sending response (size: 16, retcode: Succ=
ess) (in thread_manage_clients() at main.c:3909)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/407]: Updating kernel poll set (in update_kerne=
l_poll() at main.c:689)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/407]: Thread kernel polling on 2 fds (in thread=
_manage_kernel() at main.c:874)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/399]: [ht-thread] Polling on 2 fds. (in thread_=
ht_cleanup() at ht-cleanup.c:64)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/399]: [ht-thread] Polling on 2 fds. (in thread_=
ht_cleanup() at ht-cleanup.c:64)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 8 (in process_c=
lient_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Waiting for 1 URIs from client ... (in pr=
ocess_client_msg() at main.c:3201)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151806 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/401]: Created hashtable size 4 at 0x74105a68 of=
 type 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Tracing session auto-20150313-151806 crea=
ted with ID 1 by UID 0 GID 0 (in session_create() at session.c:276)<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151806 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/401]: Created hashtable size 4 at 0x7410ac50 of=
 type 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Setting trace directory path from URI to =
/home/root/lttng-traces/auto-20150313-151806 (in add_uri_to_consumer() at c=
md.c:481)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Sending response (size: 16, retcode: Succ=
ess) (in thread_manage_clients() at main.c:3909)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 16 (in process_=
client_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Getting session auto-20150313-151806 by n=
ame (in process_client_msg() at main.c:2716)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151806 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Sending response (size: 16, retcode: No c=
hannel found in the session) (in thread_manage_clients() at main.c:3909)<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 17 (in process_=
client_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Getting session auto-20150313-151806 by n=
ame (in process_client_msg() at main.c:2716)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151806 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Sending response (size: 16, retcode: Trac=
ing already stopped) (in thread_manage_clients() at main.c:3909)<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 24 (in process_=
client_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Getting session auto-20150313-151806 by n=
ame (in process_client_msg() at main.c:2716)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-151806 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Sending response (size: 16, retcode: Unkn=
own error code) (in thread_manage_clients() at main.c:3909)<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Nothing recv() from client... continuing =
(in thread_manage_clients() at main.c:3864)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Clean command context structure (in clean=
_command_ctx() at main.c:608)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Accepting client command ... (in thread_m=
anage_clients() at main.c:3773)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Wait for client response (in thread_manag=
e_clients() at main.c:3815)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Receiving data from client ... (in thread=
_manage_clients() at main.c:3860)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Processing client command 8 (in process_c=
lient_msg() at main.c:2637)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Waiting for 1 URIs from client ... (in pr=
ocess_client_msg() at main.c:3201)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-152018 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/401]: Created hashtable size 4 at 0x7410afc8 of=
 type 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG1 [300/401]: Tracing session auto-20150313-152018 crea=
ted with ID 2 by UID 0 GID 0 (in session_create() at session.c:276)<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Trying to find session by name auto-20150=
313-152018 (in session_find_by_name() at session.c:169)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG3 [300/401]: Created hashtable size 4 at 0x741101b0 of=
 type 1 (in lttng_ht_new() at hashtable.c:127)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">DEBUG2 [300/401]: Setting trace directory path from URI to =
/home/root/lttng-traces/auto-20150313-152018 (in add_uri_to_consumer() at c=
md.c:481)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Here is the session:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">root@socfpga_cyclone5:~# lttng start<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">PERROR [528/533]: kernctl_get_timestamp_begin: Inappropriat=
e ioctl for device (in get_index_values() at kernel-consumer.c:973)<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">Tracing started for session auto-20150313-151441<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">root@socfpga_cyclone5:~# PERROR [528/533]: kernctl_get_time=
stamp_begin: Inappropriate ioctl for device (in get_index_values() at kerne=
l-consumer.c:973)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">root@socfpga_cyclone5:~# lttng stop<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">Waiting for data availability<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">Tracing stopped for session auto-20150313-151441<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">root@socfpga_cyclone5:~# ls -Rl<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">.:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">drwxrwx---&nbsp;&nbsp;&nbsp; 3 root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4096 Mar 13 15:=
14 lttng-traces<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">./lttng-traces:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">drwxrwx---&nbsp;&nbsp;&nbsp; 3 root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4096 Mar 13 15:=
14 auto-20150313-151441<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">./lttng-traces/auto-20150313-151441:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">drwxrwx---&nbsp;&nbsp;&nbsp; 3 root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4096 Mar 13 15:=
14 kernel<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">./lttng-traces/auto-20150313-151441/kernel:<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">-rw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 Mar 13 15:14 channel0_0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">-rw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 Mar 13 15:14 channel0_1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">drwxrwx---&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4096 Mar 13 15:=
14 index<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">-rw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;221184 Mar 13 15:14 metadat=
a<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">./lttng-traces/auto-20150313-151441/kernel/index:<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">-rw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 =
Mar 13 15:14 channel0_0.idx<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">-rw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 =
Mar 13 15:14 channel0_1.idx<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am using the following version of LTTng:<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">nbryan@meteor:/data/nbryan/Meteor/YoctoDaisy/poky/meta/reci=
pes-kernel/lttng$ ls -1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">babeltrace_1.1.1.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-modules<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-modules_2.3.3.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-modules_2.4.2.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-tools<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-tools_2.3.1.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-tools_2.4.0.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-ust<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-ust_2.3.1.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-ust_2.4.0.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for any clues,<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
Regards,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Neil.<o:p></o:p></p>
</div>
</body>
</html>

--_000_8369DAE2C5B8814998E89CE414A915381F6BA2BFITMailbox3TTPGr_--


--===============0827861495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0827861495==--
