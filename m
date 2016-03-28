From: aditya dogra <dogra.aditya@gmail.com>
Subject: Re: lttng-sessiond stuck at "Accepting application
	registration"
Date: Mon, 28 Mar 2016 18:21:40 +0530
Message-ID: <CANY1tR+DRtfb8zrjLeUMZE9+Ex3AHu2AzUGatN-sReObu6eiwg__8575.24556709013$1459169524$gmane$org@mail.gmail.com>
References: <CAEQ5q2Ec=Q-zcQXBx9QQ5oyDKEwxNgqVqiatdf=y79ubn6J7gg@mail.gmail.com>
 <CA+jJMxvJRQ-cE=uPtOVrOyOERAAEdvdtQR1e=+15YYp28oNiow@mail.gmail.com>
 <CAEQ5q2H_2hoB6eeFqPZDv7AOeG7oTkoAZkefYkiNg6Csy3EJ3g@mail.gmail.com>
 <CAEQ5q2E4+Ty_HTB-pUssEW26TCKmY+1=+YN-HbSSrJS5L-u9+A@mail.gmail.com>
 <CAHxF_R-jXhs9ihSa4qygcD2Fbsz+XCCvPM-ug=dWBS5JUKPsBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8077253785619279206=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4BC2BA09DE
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2016 12:51:42 +0000 (UTC)
Received: by mail-oi0-f48.google.com with SMTP id r187so169534739oih.3
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2016 05:51:42 -0700 (PDT)
In-Reply-To: <CAHxF_R-jXhs9ihSa4qygcD2Fbsz+XCCvPM-ug=dWBS5JUKPsBQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Vijay Anand <vjanandr85@gmail.com>, lttng-dev@lists.lttng.org
Cc: Prashanth Raghavendra <prashanth.raghavendra@gmail.com>
List-Id: lttng-dev@lists.lttng.org

--===============8077253785619279206==
Content-Type: multipart/alternative; boundary=001a113d7ce2c2a341052f1b5faa

--001a113d7ce2c2a341052f1b5faa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Adding Lttng-dev

We are running running a 32 bit application on a 64 bit machine. We have
built 32bit versions of both the sessiond and the consumerd.
Could anyone please point us on how do go about debugging this ?


*lttng (LTTng Trace Control) 2.7.1 - Herbe =C3=A0 D=C3=A9tourne - v2.7.1*

Facing some issues when we do "lttng start".















































*DEBUG1 - 14:22:18.457697 [9524/9556]: Wait for client response (in
thread_manage_clients() at main.c:4362)DEBUG1 - 14:22:18.457754
[9524/9556]: Receiving data from client ... (in thread_manage_clients() at
main.c:4407)DEBUG1 - 14:22:18.457776 [9524/9556]: Processing client command
16 (in process_client_msg() at main.c:2989)DEBUG1 - 14:22:18.457782
[9524/9556]: Getting session auto-20160323-142131 by name (in
process_client_msg() at main.c:3076)DEBUG2 - 14:22:18.457788 [9524/9556]:
Trying to find session by name auto-20160323-142131 (in
session_find_by_name() at session.c:172)DEBUG1 - 14:22:18.457797
[9524/9556]: Starting all UST traces (in ust_app_start_trace_all() at
ust-app.c:4592)DEBUG1 - 14:22:18.457804 [9524/9556]: Starting tracing for
ust app pid 11876 (in ust_app_start_trace() at ust-app.c:4205)DEBUG3 -
14:22:18.457811 [9524/9556]: mkdir() recursive
/root/lttng-traces/auto-20160323-142131 with mode 504 for uid 0 and gid 0
(in run_as_mkdir_recursive() at runas.c:468)DEBUG1 - 14:22:18.457821
[9524/9556]: Using run_as worker (in run_as() at runas.c:449)DEBUG3 -
14:22:18.457871 [9524/9556]: Buffer registry per UID find id: 2, ABI: 32,
uid: 499 (in buffer_reg_uid_find() at buffer-registry.c:204)DEBUG3 -
14:22:18.457885 [9524/9556]: Created hashtable size 4 at 0xf4233240 of type
1 (in lttng_ht_new() at hashtable.c:136)DEBUG3 - 14:22:18.457893
[9524/9556]: Created hashtable size 4 at 0xf4233318 of type 0 (in
lttng_ht_new() at hashtable.c:136)DEBUG3 - 14:22:18.457899 [9524/9556]: UST
app channel metadata allocated (in alloc_ust_app_channel() at
ust-app.c:967)DEBUG2 - 14:22:18.457906 [9524/9556]: Asking UST consumer for
channel (in ask_channel_creation() at ust-consumer.c:121)DEBUG3 -
14:22:18.457914 [9524/9556]: mkdir() recursive
/root/lttng-traces/auto-20160323-142131/ust/uid/499/32-bit with mode 504
for uid 0 and gid 0 (in run_as_mkdir_recursive() at runas.c:468)DEBUG1 -
14:22:18.457921 [9524/9556]: Using run_as worker (in run_as() at
runas.c:449)DEBUG2 - 14:22:18.458130 [9524/9556]: UST ask channel 6
successfully done with 1 stream(s) (in ask_channel_creation() at
ust-consumer.c:216)DEBUG2 - 14:22:18.458139 [9524/9556]: Consumer setup
metadata channel key 6 (in consumer_setup_metadata() at
consumer.c:1236)DEBUG2 - 14:22:18.458176 [9524/9556]: UST metadata with key
6 created for app pid 11876 (in create_ust_app_metadata() at
ust-app.c:3133)DEBUG3 - 14:22:18.458183 [9524/9556]: UST app deleting
channel metadata (in delete_ust_app_channel() at ust-app.c:391)DEBUG3 -
14:22:18.458276 [9524/9560]: [ust-thread] Manage notify return from poll on
3 fds (in ust_thread_manage_notify() at ust-thread.c:76)DEBUG3 -
14:22:18.458289 [9524/9560]: UST app receiving notify from sock 33 (in
ust_app_recv_notify() at ust-app.c:5289)DEBUG2 - 14:22:18.458297
[9524/9560]: UST app ustctl register channel received (in
ust_app_recv_notify() at ust-app.c:5343)DEBUG3 - 14:22:18.458309
[9524/9560]: Buffer registry per UID find id: 2, ABI: 32, uid: 499 (in
buffer_reg_uid_find() at buffer-registry.c:204)Error: Error starting
tracing for app pid: 11876 (ret: -1024)DEBUG3 - 14:22:22.453769
[9524/9560]: UST registry channel finding key 0 (in
ust_registry_channel_find() at ust-registry.c:490)DEBUG1 - 14:22:22.453780
[9524/9556]: Sending response (size: 16, retcode: Success) (in
thread_manage_clients() at main.c:4456)DEBUG3 - 14:22:22.453787
[9524/9560]: Append to metadata: "stream {        id =3D 0;
event.header :=3D struct event_header_compact;        packet.context :=3D
struct packet_context;" (in lttng_metadata_printf() at
ust-metadata.c:175)DEBUG1 - 14:22:22.453811 [9524/9556]: Clean command
context structure (in clean_command_ctx() at main.c:829)DEBUG3 -
14:22:22.453813 [9524/9560]: Append to metadata: "};" (in
lttng_metadata_printf() at ust-metadata.c:175)DEBUG1 - 14:22:22.453821
[9524/9556]: Accepting client command ... (in thread_manage_clients() at
main.c:4310)DEBUG3 - 14:22:22.453829 [9524/9560]: UST app replying to
register channel key 0 with id 0, type: 1, ret: 0 (in
reply_ust_register_channel() at ust-app.c:5155)DEBUG3 - 14:22:22.453839
[9524/9560]: UST app reply channel failed. Application died (in
reply_ust_register_channel() at ust-app.c:5162)DEBUG1 - 14:22:22.453851
[9524/9560]: UST app notify socket unregister 33 (in
ust_app_notify_sock_unregister() at ust-app.c:5417)Tracing started for
session auto-20160323-142131DEBUG3 - 14:22:22.453860 [9524/9560]:
[ust-thread] Manage notify polling (in ust_thread_manage_notify() at
ust-thread.c:69)DEBUG3 - 14:22:22.453865 [9524/9526]: [ht-thread] Returning
from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:74)DEBUG3 -
14:22:22.453882 [9524/9526]: [ht-thread] Polling. (in thread_ht_cleanup()
at ht-cleanup.c:67)DEBUG3 - 14:22:22.453888 [9524/9526]: [ht-thread]
Returning from poll on 2 fds. (in thread_ht_cleanup() at
ht-cleanup.c:74)DEBUG3 - 14:22:22.453895 [9524/9526]: [ht-thread] Polling.
(in thread_ht_cleanup() at ht-cleanup.c:67)*


We believe that due to the above issue, no traces are created.












*lttng viewDEBUG1 - 14:24:26.807884 [9524/9556]: Wait for client response
(in thread_manage_clients() at main.c:4362)DEBUG1 - 14:24:26.807934
[9524/9556]: Receiving data from client ... (in thread_manage_clients() at
main.c:4407)DEBUG1 - 14:24:26.807955 [9524/9556]: Processing client command
13 (in process_client_msg() at main.c:2989)DEBUG1 - 14:24:26.807962
[9524/9556]: Counting number of available session for UID 0 GID 0 (in
lttng_sessions_count() at main.c:2958)DEBUG1 - 14:24:26.807970 [9524/9556]:
Getting all available session for UID 0 GID 0 (in cmd_list_lttng_sessions()
at cmd.c:2783)DEBUG1 - 14:24:26.807978 [9524/9556]: Sending response (size:
4392, retcode: Success) (in thread_manage_clients() at main.c:4456)DEBUG1 -
14:24:26.807999 [9524/9556]: Clean command context structure (in
clean_command_ctx() at main.c:829)DEBUG1 - 14:24:26.808006 [9524/9556]:
Accepting client command ... (in thread_manage_clients() at
main.c:4310)Trace directory: /root/lttng-traces/auto-20160323-142131*



We are using tracef() in our application.





*#include <lttng/tracef.h>tracef("my message, my integer: %d", 0x1234);*


















































*lttng list --userspaceDEBUG1 - 14:21:17.747867 [9524/9556]: Wait for
client response (in thread_manage_clients() at main.c:4362)DEBUG1 -
14:21:17.747921 [9524/9556]: Receiving data from client ... (in
thread_manage_clients() at main.c:4407)DEBUG1 - 14:21:17.747943
[9524/9556]: Processing client command 14 (in process_client_msg() at
main.c:2989)DEBUG2 - 14:21:17.748521 [9524/9556]: Reallocating event list
from 32 to 64 entries (in ust_app_list_events() at ust-app.c:3502)DEBUG2 -
14:21:17.748623 [9524/9556]: UST app list events done (35 events) (in
ust_app_list_events() at ust-app.c:3543)DEBUG1 - 14:21:17.748638
[9524/9556]: Sending response (size: 20456, retcode: Success) (in
thread_manage_clients() at main.c:4456)DEBUG1 - 14:21:17.748663
[9524/9556]: Clean command context structure (in clean_command_ctx() at
main.c:829)DEBUG1 - 14:21:17.748670 [9524/9556]: Accepting client command
... (in thread_manage_clients() at main.c:4310)UST events:-------------PID:
11876 - Name: <process_name>      lttng_ust_cyg_profile_fast:func_exit
(loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
lttng_ust_cyg_profile_fast:func_entry (loglevel: TRACE_DEBUG_FUNCTION (12))
(type: tracepoint)      lttng_ust_cyg_profile:func_exit (loglevel:
TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
lttng_ust_cyg_profile:func_entry (loglevel: TRACE_DEBUG_FUNCTION (12))
(type: tracepoint)      lttng_ust_dl:dlclose (loglevel: TRACE_DEBUG_LINE
(13)) (type: tracepoint)      lttng_ust_dl:dlopen (loglevel:
TRACE_DEBUG_LINE (13)) (type: tracepoint)
lttng_ust_libc:posix_memalign (loglevel: TRACE_DEBUG_LINE (13)) (type:
tracepoint)      lttng_ust_libc:memalign (loglevel: TRACE_DEBUG_LINE (13))
(type: tracepoint)      lttng_ust_libc:realloc (loglevel: TRACE_DEBUG_LINE
(13)) (type: tracepoint)      lttng_ust_libc:calloc (loglevel:
TRACE_DEBUG_LINE (13)) (type: tracepoint)      lttng_ust_libc:free
(loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
lttng_ust_libc:malloc (loglevel: TRACE_DEBUG_LINE (13)) (type:
tracepoint)      lttng_ust_pthread:pthread_mutex_unlock (loglevel:
TRACE_DEBUG_LINE (13)) (type: tracepoint)
lttng_ust_pthread:pthread_mutex_trylock (loglevel: TRACE_DEBUG_LINE (13))
(type: tracepoint)      lttng_ust_pthread:pthread_mutex_lock_acq (loglevel:
TRACE_DEBUG_LINE (13)) (type: tracepoint)
lttng_ust_pthread:pthread_mutex_lock_req (loglevel: TRACE_DEBUG_LINE (13))
(type: tracepoint)      lttng_ust_tracelog:TRACE_DEBUG (loglevel:
TRACE_DEBUG (14)) (type: tracepoint)
lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE (13))
(type: tracepoint)      lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (loglevel:
TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEBUG_UNIT (11))
(type: tracepoint)      lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglevel:
TRACE_DEBUG_MODULE (10)) (type: tracepoint)
lttng_ust_tracelog:TRACE_DEBUG_PROCESS (loglevel: TRACE_DEBUG_PROCESS (9))
(type: tracepoint)      lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel:
TRACE_DEBUG_PROGRAM (8)) (type: tracepoint)
lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel: TRACE_DEBUG_SYSTEM (7))
(type: tracepoint)      lttng_ust_tracelog:TRACE_INFO (loglevel: TRACE_INFO
(6)) (type: tracepoint)      lttng_ust_tracelog:TRACE_NOTICE (loglevel:
TRACE_NOTICE (5)) (type: tracepoint)      lttng_ust_tracelog:TRACE_WARNING
(loglevel: TRACE_WARNING (4)) (type: tracepoint)
lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (type:
tracepoint)      lttng_ust_tracelog:TRACE_CRIT (loglevel: TRACE_CRIT (2))
(type: tracepoint)      lttng_ust_tracelog:TRACE_ALERT (loglevel:
TRACE_ALERT (1)) (type: tracepoint)      lttng_ust_tracelog:TRACE_EMERG
(loglevel: TRACE_EMERG (0)) (type: tracepoint)      lttng_ust_tracef:event
(loglevel: TRACE_DEBUG (14)) (type: tracepoint)
lttng_ust_statedump:end (loglevel: TRACE_DEBUG_LINE (13)) (type:
tracepoint)      lttng_ust_statedump:soinfo (loglevel: TRACE_DEBUG_LINE
(13)) (type: tracepoint)      lttng_ust_statedump:start (loglevel:
TRACE_DEBUG_LINE (13)) (type: tracepoint)*



Kindly help us in fixing this issue.

Regards,
Aditya Dogra
"When the going gets tough, the tough get going"

On Mon, Mar 28, 2016 at 3:38 PM, Vijay Anand <vjanandr85@gmail.com> wrote:

> Just to add, we are running running a 32 bit application on a 64 bit
> machine. We have built 32bit versions of both the sessiond and the
> consumerd.
> Could anyone please point us on how do go about debugging this ?
>
> Regards,
> Vijay
>
> On Wed, Mar 23, 2016 at 6:10 PM, Prashanth Raghavendra <
> prashanth.raghavendra@gmail.com> wrote:
>
>> Hi Jeremie,
>>
>> We upgraded to LTTNG 2.7.
>>
>>
>> *lttng (LTTng Trace Control) 2.7.1 - Herbe =C3=A0 D=C3=A9tourne - v2.7.1=
*
>>
>> Facing some issues when we do "lttng start".
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> *DEBUG1 - 14:22:18.457697 [9524/9556]: Wait for client response (in
>> thread_manage_clients() at main.c:4362)DEBUG1 - 14:22:18.457754
>> [9524/9556]: Receiving data from client ... (in thread_manage_clients() =
at
>> main.c:4407)DEBUG1 - 14:22:18.457776 [9524/9556]: Processing client comm=
and
>> 16 (in process_client_msg() at main.c:2989)DEBUG1 - 14:22:18.457782
>> [9524/9556]: Getting session auto-20160323-142131 by name (in
>> process_client_msg() at main.c:3076)DEBUG2 - 14:22:18.457788 [9524/9556]=
:
>> Trying to find session by name auto-20160323-142131 (in
>> session_find_by_name() at session.c:172)DEBUG1 - 14:22:18.457797
>> [9524/9556]: Starting all UST traces (in ust_app_start_trace_all() at
>> ust-app.c:4592)DEBUG1 - 14:22:18.457804 [9524/9556]: Starting tracing fo=
r
>> ust app pid 11876 (in ust_app_start_trace() at ust-app.c:4205)DEBUG3 -
>> 14:22:18.457811 [9524/9556]: mkdir() recursive
>> /root/lttng-traces/auto-20160323-142131 with mode 504 for uid 0 and gid =
0
>> (in run_as_mkdir_recursive() at runas.c:468)DEBUG1 - 14:22:18.457821
>> [9524/9556]: Using run_as worker (in run_as() at runas.c:449)DEBUG3 -
>> 14:22:18.457871 [9524/9556]: Buffer registry per UID find id: 2, ABI: 32=
,
>> uid: 499 (in buffer_reg_uid_find() at buffer-registry.c:204)DEBUG3 -
>> 14:22:18.457885 [9524/9556]: Created hashtable size 4 at 0xf4233240 of t=
ype
>> 1 (in lttng_ht_new() at hashtable.c:136)DEBUG3 - 14:22:18.457893
>> [9524/9556]: Created hashtable size 4 at 0xf4233318 of type 0 (in
>> lttng_ht_new() at hashtable.c:136)DEBUG3 - 14:22:18.457899 [9524/9556]: =
UST
>> app channel metadata allocated (in alloc_ust_app_channel() at
>> ust-app.c:967)DEBUG2 - 14:22:18.457906 [9524/9556]: Asking UST consumer =
for
>> channel (in ask_channel_creation() at ust-consumer.c:121)DEBUG3 -
>> 14:22:18.457914 [9524/9556]: mkdir() recursive
>> /root/lttng-traces/auto-20160323-142131/ust/uid/499/32-bit with mode 504
>> for uid 0 and gid 0 (in run_as_mkdir_recursive() at runas.c:468)DEBUG1 -
>> 14:22:18.457921 [9524/9556]: Using run_as worker (in run_as() at
>> runas.c:449)DEBUG2 - 14:22:18.458130 [9524/9556]: UST ask channel 6
>> successfully done with 1 stream(s) (in ask_channel_creation() at
>> ust-consumer.c:216)DEBUG2 - 14:22:18.458139 [9524/9556]: Consumer setup
>> metadata channel key 6 (in consumer_setup_metadata() at
>> consumer.c:1236)DEBUG2 - 14:22:18.458176 [9524/9556]: UST metadata with =
key
>> 6 created for app pid 11876 (in create_ust_app_metadata() at
>> ust-app.c:3133)DEBUG3 - 14:22:18.458183 [9524/9556]: UST app deleting
>> channel metadata (in delete_ust_app_channel() at ust-app.c:391)DEBUG3 -
>> 14:22:18.458276 [9524/9560]: [ust-thread] Manage notify return from poll=
 on
>> 3 fds (in ust_thread_manage_notify() at ust-thread.c:76)DEBUG3 -
>> 14:22:18.458289 [9524/9560]: UST app receiving notify from sock 33 (in
>> ust_app_recv_notify() at ust-app.c:5289)DEBUG2 - 14:22:18.458297
>> [9524/9560]: UST app ustctl register channel received (in
>> ust_app_recv_notify() at ust-app.c:5343)DEBUG3 - 14:22:18.458309
>> [9524/9560]: Buffer registry per UID find id: 2, ABI: 32, uid: 499 (in
>> buffer_reg_uid_find() at buffer-registry.c:204)Error: Error starting
>> tracing for app pid: 11876 (ret: -1024)DEBUG3 - 14:22:22.453769
>> [9524/9560]: UST registry channel finding key 0 (in
>> ust_registry_channel_find() at ust-registry.c:490)DEBUG1 - 14:22:22.4537=
80
>> [9524/9556]: Sending response (size: 16, retcode: Success) (in
>> thread_manage_clients() at main.c:4456)DEBUG3 - 14:22:22.453787
>> [9524/9560]: Append to metadata: "stream {        id =3D 0;
>> event.header :=3D struct event_header_compact;        packet.context :=
=3D
>> struct packet_context;" (in lttng_metadata_printf() at
>> ust-metadata.c:175)DEBUG1 - 14:22:22.453811 [9524/9556]: Clean command
>> context structure (in clean_command_ctx() at main.c:829)DEBUG3 -
>> 14:22:22.453813 [9524/9560]: Append to metadata: "};" (in
>> lttng_metadata_printf() at ust-metadata.c:175)DEBUG1 - 14:22:22.453821
>> [9524/9556]: Accepting client command ... (in thread_manage_clients() at
>> main.c:4310)DEBUG3 - 14:22:22.453829 [9524/9560]: UST app replying to
>> register channel key 0 with id 0, type: 1, ret: 0 (in
>> reply_ust_register_channel() at ust-app.c:5155)DEBUG3 - 14:22:22.453839
>> [9524/9560]: UST app reply channel failed. Application died (in
>> reply_ust_register_channel() at ust-app.c:5162)DEBUG1 - 14:22:22.453851
>> [9524/9560]: UST app notify socket unregister 33 (in
>> ust_app_notify_sock_unregister() at ust-app.c:5417)Tracing started for
>> session auto-20160323-142131DEBUG3 - 14:22:22.453860 [9524/9560]:
>> [ust-thread] Manage notify polling (in ust_thread_manage_notify() at
>> ust-thread.c:69)DEBUG3 - 14:22:22.453865 [9524/9526]: [ht-thread] Return=
ing
>> from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:74)DEBUG3 -
>> 14:22:22.453882 [9524/9526]: [ht-thread] Polling. (in thread_ht_cleanup(=
)
>> at ht-cleanup.c:67)DEBUG3 - 14:22:22.453888 [9524/9526]: [ht-thread]
>> Returning from poll on 2 fds. (in thread_ht_cleanup() at
>> ht-cleanup.c:74)DEBUG3 - 14:22:22.453895 [9524/9526]: [ht-thread] Pollin=
g.
>> (in thread_ht_cleanup() at ht-cleanup.c:67)*
>>
>>
>> We believe that due to the above issue, no traces are created.
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> *lttng viewDEBUG1 - 14:24:26.807884 [9524/9556]: Wait for client respons=
e
>> (in thread_manage_clients() at main.c:4362)DEBUG1 - 14:24:26.807934
>> [9524/9556]: Receiving data from client ... (in thread_manage_clients() =
at
>> main.c:4407)DEBUG1 - 14:24:26.807955 [9524/9556]: Processing client comm=
and
>> 13 (in process_client_msg() at main.c:2989)DEBUG1 - 14:24:26.807962
>> [9524/9556]: Counting number of available session for UID 0 GID 0 (in
>> lttng_sessions_count() at main.c:2958)DEBUG1 - 14:24:26.807970 [9524/955=
6]:
>> Getting all available session for UID 0 GID 0 (in cmd_list_lttng_session=
s()
>> at cmd.c:2783)DEBUG1 - 14:24:26.807978 [9524/9556]: Sending response (si=
ze:
>> 4392, retcode: Success) (in thread_manage_clients() at main.c:4456)DEBUG=
1 -
>> 14:24:26.807999 [9524/9556]: Clean command context structure (in
>> clean_command_ctx() at main.c:829)DEBUG1 - 14:24:26.808006 [9524/9556]:
>> Accepting client command ... (in thread_manage_clients() at
>> main.c:4310)Trace directory: /root/lttng-traces/auto-20160323-142131*
>>
>>
>>
>> We are using tracef() in our application.
>>
>>
>>
>>
>>
>> *#include <lttng/tracef.h>tracef("my message, my integer: %d", 0x1234);*
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> *lttng list --userspaceDEBUG1 - 14:21:17.747867 [9524/9556]: Wait for
>> client response (in thread_manage_clients() at main.c:4362)DEBUG1 -
>> 14:21:17.747921 [9524/9556]: Receiving data from client ... (in
>> thread_manage_clients() at main.c:4407)DEBUG1 - 14:21:17.747943
>> [9524/9556]: Processing client command 14 (in process_client_msg() at
>> main.c:2989)DEBUG2 - 14:21:17.748521 [9524/9556]: Reallocating event lis=
t
>> from 32 to 64 entries (in ust_app_list_events() at ust-app.c:3502)DEBUG2=
 -
>> 14:21:17.748623 [9524/9556]: UST app list events done (35 events) (in
>> ust_app_list_events() at ust-app.c:3543)DEBUG1 - 14:21:17.748638
>> [9524/9556]: Sending response (size: 20456, retcode: Success) (in
>> thread_manage_clients() at main.c:4456)DEBUG1 - 14:21:17.748663
>> [9524/9556]: Clean command context structure (in clean_command_ctx() at
>> main.c:829)DEBUG1 - 14:21:17.748670 [9524/9556]: Accepting client comman=
d
>> ... (in thread_manage_clients() at main.c:4310)UST events:-------------P=
ID:
>> 11876 - Name: <process_name>      lttng_ust_cyg_profile_fast:func_exit
>> (loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
>> lttng_ust_cyg_profile_fast:func_entry (loglevel: TRACE_DEBUG_FUNCTION (1=
2))
>> (type: tracepoint)      lttng_ust_cyg_profile:func_exit (loglevel:
>> TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
>> lttng_ust_cyg_profile:func_entry (loglevel: TRACE_DEBUG_FUNCTION (12))
>> (type: tracepoint)      lttng_ust_dl:dlclose (loglevel: TRACE_DEBUG_LINE
>> (13)) (type: tracepoint)      lttng_ust_dl:dlopen (loglevel:
>> TRACE_DEBUG_LINE (13)) (type: tracepoint)
>> lttng_ust_libc:posix_memalign (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)      lttng_ust_libc:memalign (loglevel: TRACE_DEBUG_LINE (13=
))
>> (type: tracepoint)      lttng_ust_libc:realloc (loglevel: TRACE_DEBUG_LI=
NE
>> (13)) (type: tracepoint)      lttng_ust_libc:calloc (loglevel:
>> TRACE_DEBUG_LINE (13)) (type: tracepoint)      lttng_ust_libc:free
>> (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
>> lttng_ust_libc:malloc (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)      lttng_ust_pthread:pthread_mutex_unlock (loglevel:
>> TRACE_DEBUG_LINE (13)) (type: tracepoint)
>> lttng_ust_pthread:pthread_mutex_trylock (loglevel: TRACE_DEBUG_LINE (13)=
)
>> (type: tracepoint)      lttng_ust_pthread:pthread_mutex_lock_acq (loglev=
el:
>> TRACE_DEBUG_LINE (13)) (type: tracepoint)
>> lttng_ust_pthread:pthread_mutex_lock_req (loglevel: TRACE_DEBUG_LINE (13=
))
>> (type: tracepoint)      lttng_ust_tracelog:TRACE_DEBUG (loglevel:
>> TRACE_DEBUG (14)) (type: tracepoint)
>> lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE (13))
>> (type: tracepoint)      lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (logleve=
l:
>> TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
>> lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEBUG_UNIT (11))
>> (type: tracepoint)      lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglevel:
>> TRACE_DEBUG_MODULE (10)) (type: tracepoint)
>> lttng_ust_tracelog:TRACE_DEBUG_PROCESS (loglevel: TRACE_DEBUG_PROCESS (9=
))
>> (type: tracepoint)      lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel=
:
>> TRACE_DEBUG_PROGRAM (8)) (type: tracepoint)
>> lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel: TRACE_DEBUG_SYSTEM (7))
>> (type: tracepoint)      lttng_ust_tracelog:TRACE_INFO (loglevel: TRACE_I=
NFO
>> (6)) (type: tracepoint)      lttng_ust_tracelog:TRACE_NOTICE (loglevel:
>> TRACE_NOTICE (5)) (type: tracepoint)      lttng_ust_tracelog:TRACE_WARNI=
NG
>> (loglevel: TRACE_WARNING (4)) (type: tracepoint)
>> lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (type:
>> tracepoint)      lttng_ust_tracelog:TRACE_CRIT (loglevel: TRACE_CRIT (2)=
)
>> (type: tracepoint)      lttng_ust_tracelog:TRACE_ALERT (loglevel:
>> TRACE_ALERT (1)) (type: tracepoint)      lttng_ust_tracelog:TRACE_EMERG
>> (loglevel: TRACE_EMERG (0)) (type: tracepoint)      lttng_ust_tracef:eve=
nt
>> (loglevel: TRACE_DEBUG (14)) (type: tracepoint)
>> lttng_ust_statedump:end (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)      lttng_ust_statedump:soinfo (loglevel: TRACE_DEBUG_LINE
>> (13)) (type: tracepoint)      lttng_ust_statedump:start (loglevel:
>> TRACE_DEBUG_LINE (13)) (type: tracepoint)*
>>
>>
>>
>> Kindly help us in fixing this issue.
>>
>>
>>
>>
>> Regards,
>> Prashanth
>>
>> On Mon, Feb 15, 2016 at 6:20 PM, Prashanth Raghavendra <
>> prashanth.raghavendra@gmail.com> wrote:
>>
>>> Hi Jeremie,
>>>
>>> Thanks for the clarification.
>>> We will try with the latest version.
>>>
>>>
>>> Regards,
>>> Prashanth
>>>
>>> On Fri, Feb 12, 2016 at 10:10 PM, J=C3=A9r=C3=A9mie Galarneau <
>>> jeremie.galarneau@efficios.com> wrote:
>>>
>>>> On Fri, Feb 12, 2016 at 8:57 AM, Prashanth Raghavendra
>>>> <prashanth.raghavendra@gmail.com> wrote:
>>>> > Greetings,
>>>> >
>>>> > We are trying to use lttng for tracing our application code
>>>> (userspace).
>>>> >
>>>> > Host OS:  WR5.0.1.13 Linux
>>>> > Lttng-tools version 2.1.0, 32-bit  (lttng: ELF 32-bit LSB executable=
,
>>>> Intel
>>>> > 80386)
>>>> > Babeltrace version 1.0.0
>>>> >
>>>>
>>>> Hi,
>>>>
>>>> Unfortunately, both of these versions have been unsupported for a long
>>>> time.
>>>> Let us know if the problem still occurs with the latest LTTng and
>>>> Babeltrace releases.
>>>>
>>>> Regards,
>>>> J=C3=A9r=C3=A9mie
>>>>
>>>> > Logged in as root.
>>>> >
>>>> >
>>>> >
>>>> > When we start the lttng-sessiond, it gets stuck at "Accepting
>>>> application
>>>> > registration=E2=80=9D.
>>>> >
>>>> > Linux(debug)# /isan/lib/lttng-sessiond -vvv --no-kernel
>>>> > DEBUG3: Creating LTTng run directory: /var/run/lttng [in
>>>> > create_lttng_rundir() at main.c:3683]
>>>> > DEBUG2: Kernel consumer err path: /var/run/lttng/kconsumerd/error [i=
n
>>>> main()
>>>> > at main.c:3931]
>>>> > DEBUG2: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command
>>>> [in
>>>> > main() at main.c:3933]
>>>> > DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond [in
>>>> main()
>>>> > at main.c:3986]
>>>> > DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond [=
in
>>>> > main() at main.c:3987]
>>>> > DEBUG1: LTTng run directory path: /var/run/lttng [in main() at
>>>> main.c:3988]
>>>> > DEBUG2: UST consumer 32 bits err path:
>>>> /var/run/lttng/ustconsumerd32/error
>>>> > [in main() at main.c:3997]
>>>> > DEBUG2: UST consumer 32 bits cmd path:
>>>> /var/run/lttng/ustconsumerd32/command
>>>> > [in main() at main.c:3999]
>>>> > DEBUG2: UST consumer 64 bits err path:
>>>> /var/run/lttng/ustconsumerd64/error
>>>> > [in main() at main.c:4008]
>>>> > DEBUG2: UST consumer 64 bits cmd path:
>>>> /var/run/lttng/ustconsumerd64/command
>>>> > [in main() at main.c:4010]
>>>> > DEBUG3: Created hashtable size 4 at 0x88d7080 of type 1 [in
>>>> lttng_ht_new()
>>>> > at hashtable.c:96]
>>>> > DEBUG3: Created hashtable size 4 at 0x88d7370 of type 1 [in
>>>> lttng_ht_new()
>>>> > at hashtable.c:96]
>>>> > DEBUG2: Creating consumer directory: /var/run/lttng/kconsumerd [in
>>>> > set_consumer_sockets() at main.c:3725]
>>>> > DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd64 [=
in
>>>> > set_consumer_sockets() at main.c:3725]
>>>> > DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd32 [=
in
>>>> > set_consumer_sockets() at main.c:3725]
>>>> > DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT [in
>>>> > set_signal_handler() at main.c:3817]
>>>> > DEBUG3: Session daemon client socket 8 and application socket 9
>>>> created [in
>>>> > init_daemon_socket() at main.c:3587]
>>>> > Warning: No tracing group detected
>>>> > DEBUG1: epoll set max size is 3243642 [in compat_epoll_set_max_size(=
)
>>>> at
>>>> > compat-epoll.c:224]
>>>> > DEBUG1: Command subsystem initialized [in cmd_init() at cmd.c:2423]
>>>> > DEBUG1: [thread] Manage health check started [in
>>>> thread_manage_health() at
>>>> > main.c:2944]
>>>> > DEBUG1: [thread] Manage client started [in thread_manage_clients() a=
t
>>>> > main.c:3138]
>>>> > DEBUG1: [thread] Dispatch UST command started [in
>>>> > thread_dispatch_ust_registration() at main.c:1295]
>>>> > DEBUG1: Futex n to 1 prepare done [in futex_nto1_prepare() at
>>>> futex.c:75]
>>>> > DEBUG1: Woken up but nothing in the UST command queue [in
>>>> > thread_dispatch_ust_registration() at main.c:1305]
>>>> > DEBUG1: [thread] Manage application registration started [in
>>>> > thread_registration_apps() at main.c:1371]
>>>> > DEBUG1: [thread] Manage application started [in thread_manage_apps()
>>>> at
>>>> > main.c:1101]
>>>> > DEBUG1: Health check ready [in thread_manage_health() at main.c:2983=
]
>>>> > DEBUG1: Accepting client command ... [in thread_manage_clients() at
>>>> > main.c:3182]
>>>> > DEBUG1: Notifying applications of session daemon state: 1 [in
>>>> > notify_ust_apps() at main.c:496]
>>>> > DEBUG1: Apps thread polling on 2 fds [in thread_manage_apps() at
>>>> > main.c:1134]
>>>> > DEBUG1: Got the wait shm fd 16 [in get_wait_shm() at shm.c:117]
>>>> > DEBUG1: Futex wait update active 1 [in futex_wait_update() at
>>>> futex.c:63]
>>>> > DEBUG1: Accepting application registration [in
>>>> thread_registration_apps() at
>>>> > main.c:1406]  =3D=3D=3D=C3=A8 Remain struck here
>>>> >
>>>> >
>>>> >
>>>> > Because of this, we suspect that the traces from our application are
>>>> not
>>>> > getting generated. And we get error when we run lttng view:
>>>> > (lttng enable-event, start etc went through fine)
>>>> >
>>>> > Linux(debug)# lttng stop
>>>> > Waiting for data availability
>>>> > Warning: Tracing already stopped for session auto-20160211-133851
>>>> > Linux(debug)# lttng view
>>>> > Trace directory: /home/
>>>> >
>>>> > [error] Cannot open any trace for reading.
>>>> >
>>>> > [error] opening trace =E2=80=9C/home/" for reading.
>>>> >
>>>> > [error] none of the specified trace paths could be opened.
>>>> >
>>>> >
>>>> >
>>>> > Please help us in fixing this issue.
>>>> >
>>>> > Thank you.
>>>> >
>>>> >
>>>> >
>>>> >
>>>> > Best Regards,
>>>> >
>>>> > Prashanth Raghavendra
>>>> > Aditya Dogra
>>>> >
>>>> >
>>>> >
>>>> >
>>>> >
>>>> > _______________________________________________
>>>> > lttng-dev mailing list
>>>> > lttng-dev@lists.lttng.org
>>>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>> >
>>>>
>>>>
>>>>
>>>> --
>>>> J=C3=A9r=C3=A9mie Galarneau
>>>> EfficiOS Inc.
>>>> http://www.efficios.com
>>>>
>>>
>>>
>>
>

--001a113d7ce2c2a341052f1b5faa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Adding Lttng-dev <br><div><br>We
 are running running a 32 bit application on a 64 bit machine. We have=20
built 32bit versions of both the sessiond and the consumerd.<div class=3D"g=
mail_default" style=3D"font-family:verdana,sans-serif;font-size:small;color=
:rgb(0,0,255)">Could anyone please point us on how do go about debugging th=
is ?<br><br><i><b>lttng (LTTng Trace Control) 2.7.1 - Herbe =C3=A0 D=C3=A9t=
ourne - v2.7.1<br></b></i><br><br>Facing some issues when we do &quot;lttng=
 start&quot;. <br><i><br>DEBUG1 - <span tabindex=3D"0" class=3D""><span cla=
ss=3D"">14:22:18.457697</span></span> [9524/9556]: Wait for client response=
 (in thread_manage_clients() at main.c:4362)<br>DEBUG1 - <span tabindex=3D"=
0" class=3D""><span class=3D"">14:22:18.457754</span></span> [9524/9556]: R=
eceiving data from client ... (in thread_manage_clients() at main.c:4407)<b=
r>DEBUG1 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:18.457776=
</span></span> [9524/9556]: Processing client command 16 (in process_client=
_msg() at main.c:2989)<br>DEBUG1 - <span tabindex=3D"0" class=3D""><span cl=
ass=3D"">14:22:18.457782</span></span> [9524/9556]: Getting session auto-20=
160323-142131 by name (in process_client_msg() at main.c:3076)<br>DEBUG2 - =
<span tabindex=3D"0" class=3D""><span class=3D"">14:22:18.457788</span></sp=
an> [9524/9556]: Trying to find session by name auto-20160323-142131 (in se=
ssion_find_by_name() at session.c:172)<br>DEBUG1 - <span tabindex=3D"0" cla=
ss=3D""><span class=3D"">14:22:18.457797</span></span> [9524/9556]: Startin=
g all UST traces (in ust_app_start_trace_all() at ust-app.c:4592)<br>DEBUG1=
 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:18.457804</span><=
/span> [9524/9556]: Starting tracing for ust app pid 11876 (in ust_app_star=
t_trace() at ust-app.c:4205)<br>DEBUG3 - <span tabindex=3D"0" class=3D""><s=
pan class=3D"">14:22:18.457811</span></span> [9524/9556]: mkdir() recursive=
 /root/lttng-traces/auto-20160323-142131 with mode 504 for uid 0 and gid 0 =
(in run_as_mkdir_recursive() at runas.c:468)<br>DEBUG1 - <span tabindex=3D"=
0" class=3D""><span class=3D"">14:22:18.457821</span></span> [9524/9556]: U=
sing run_as worker (in run_as() at runas.c:449)<br>DEBUG3 - <span tabindex=
=3D"0" class=3D""><span class=3D"">14:22:18.457871</span></span> [9524/9556=
]: Buffer registry per UID find id: 2, ABI: 32, uid: 499 (in buffer_reg_uid=
_find() at buffer-registry.c:204)<br>DEBUG3 - <span tabindex=3D"0" class=3D=
""><span class=3D"">14:22:18.457885</span></span> [9524/9556]: Created hash=
table size 4 at 0xf4233240 of type 1 (in lttng_ht_new() at hashtable.c:136)=
<br>DEBUG3 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:18.4578=
93</span></span> [9524/9556]: Created hashtable size 4 at 0xf4233318 of typ=
e 0 (in lttng_ht_new() at hashtable.c:136)<br>DEBUG3 - <span tabindex=3D"0"=
 class=3D""><span class=3D"">14:22:18.457899</span></span> [9524/9556]: UST=
 app channel metadata allocated (in alloc_ust_app_channel() at ust-app.c:96=
7)<br>DEBUG2 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:18.45=
7906</span></span> [9524/9556]: Asking UST consumer for channel (in ask_cha=
nnel_creation() at ust-consumer.c:121)<br>DEBUG3 - <span tabindex=3D"0" cla=
ss=3D""><span class=3D"">14:22:18.457914</span></span> [9524/9556]: mkdir()=
 recursive /root/lttng-traces/auto-20160323-142131/ust/uid/499/32-bit with =
mode 504 for uid 0 and gid 0 (in run_as_mkdir_recursive() at runas.c:468)<b=
r>DEBUG1 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:18.457921=
</span></span> [9524/9556]: Using run_as worker (in run_as() at runas.c:449=
)<br>DEBUG2 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:18.458=
130</span></span> [9524/9556]: UST ask channel 6 successfully done with 1 s=
tream(s) (in ask_channel_creation() at ust-consumer.c:216)<br>DEBUG2 - <spa=
n tabindex=3D"0" class=3D""><span class=3D"">14:22:18.458139</span></span> =
[9524/9556]: Consumer setup metadata channel key 6 (in consumer_setup_metad=
ata() at consumer.c:1236)<br>DEBUG2 - <span tabindex=3D"0" class=3D""><span=
 class=3D"">14:22:18.458176</span></span> [9524/9556]: UST metadata with ke=
y 6 created for app pid 11876 (in create_ust_app_metadata() at ust-app.c:31=
33)<br>DEBUG3 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:18.4=
58183</span></span> [9524/9556]: UST app deleting channel metadata (in dele=
te_ust_app_channel() at ust-app.c:391)<br>DEBUG3 - <span tabindex=3D"0" cla=
ss=3D""><span class=3D"">14:22:18.458276</span></span> [9524/9560]: [ust-th=
read] Manage notify return from poll on 3 fds (in ust_thread_manage_notify(=
) at ust-thread.c:76)<br>DEBUG3 - <span tabindex=3D"0" class=3D""><span cla=
ss=3D"">14:22:18.458289</span></span> [9524/9560]: UST app receiving notify=
 from sock 33 (in ust_app_recv_notify() at ust-app.c:5289)<br>DEBUG2 - <spa=
n tabindex=3D"0" class=3D""><span class=3D"">14:22:18.458297</span></span> =
[9524/9560]: UST app ustctl register channel received (in ust_app_recv_noti=
fy() at ust-app.c:5343)<br>DEBUG3 - <span tabindex=3D"0" class=3D""><span c=
lass=3D"">14:22:18.458309</span></span> [9524/9560]: Buffer registry per UI=
D find id: 2, ABI: 32, uid: 499 (in buffer_reg_uid_find() at buffer-registr=
y.c:204)<br>Error: Error starting tracing for app pid: 11876 (ret: -1024)<b=
r>DEBUG3 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:22.453769=
</span></span> [9524/9560]: UST registry channel finding key 0 (in ust_regi=
stry_channel_find() at ust-registry.c:490)<br>DEBUG1 - <span tabindex=3D"0"=
 class=3D""><span class=3D"">14:22:22.453780</span></span> [9524/9556]: Sen=
ding response (size: 16, retcode: Success) (in thread_manage_clients() at m=
ain.c:4456)<br>DEBUG3 - <span tabindex=3D"0" class=3D""><span class=3D"">14=
:22:22.453787</span></span> [9524/9560]: Append to metadata: &quot;stream {=
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D 0;<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 event.header :=3D struct event_header_compact;<=
br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet.context :=3D struct pa=
cket_context;<br>&quot; (in lttng_metadata_printf() at ust-metadata.c:175)<=
br>DEBUG1 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:22.45381=
1</span></span> [9524/9556]: Clean command context structure (in clean_comm=
and_ctx() at main.c:829)<br>DEBUG3 - <span tabindex=3D"0" class=3D""><span =
class=3D"">14:22:22.453813</span></span> [9524/9560]: Append to metadata: &=
quot;};<br><br>&quot; (in lttng_metadata_printf() at ust-metadata.c:175)<br=
>DEBUG1 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:22.453821<=
/span></span> [9524/9556]: Accepting client command ... (in thread_manage_c=
lients() at main.c:4310)<br><b>DEBUG3 - <span tabindex=3D"0" class=3D""><sp=
an class=3D"">14:22:22.453829</span></span>
 [9524/9560]: UST app replying to register channel key 0 with id 0,=20
type: 1, ret: 0 (in reply_ust_register_channel() at ust-app.c:5155)<br>DEBU=
G3 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:22.453839</span=
></span> [9524/9560]: UST app reply channel failed. Application died (in re=
ply_ust_register_channel() at ust-app.c:5162)<br>DEBUG1 - <span tabindex=3D=
"0" class=3D""><span class=3D"">14:22:22.453851</span></span> [9524/9560]: =
UST app notify socket unregister 33 (in ust_app_notify_sock_unregister() at=
 ust-app.c:5417)<br>Tracing started for session auto-20160323-142131</b><br=
>DEBUG3 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:22.453860<=
/span></span> [9524/9560]: [ust-thread] Manage notify polling (in ust_threa=
d_manage_notify() at ust-thread.c:69)<br>DEBUG3 - <span tabindex=3D"0" clas=
s=3D""><span class=3D"">14:22:22.453865</span></span> [9524/9526]: [ht-thre=
ad] Returning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:7=
4)<br>DEBUG3 - <span tabindex=3D"0" class=3D""><span class=3D"">14:22:22.45=
3882</span></span> [9524/9526]: [ht-thread] Polling. (in thread_ht_cleanup(=
) at ht-cleanup.c:67)<br>DEBUG3 - <span tabindex=3D"0" class=3D""><span cla=
ss=3D"">14:22:22.453888</span></span> [9524/9526]: [ht-thread] Returning fr=
om poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:74)<br>DEBUG3 - <=
span tabindex=3D"0" class=3D""><span class=3D"">14:22:22.453895</span></spa=
n> [9524/9526]: [ht-thread] Polling. (in thread_ht_cleanup() at ht-cleanup.=
c:67)<br></i><br><br><br>We believe that due to the above issue, no traces =
are created.<br><br><br><i><b>lttng view<br>DEBUG1 - <span tabindex=3D"0" c=
lass=3D""><span class=3D"">14:24:26.807884</span></span> [9524/9556]: Wait =
for client response (in thread_manage_clients() at main.c:4362)<br>DEBUG1 -=
 <span tabindex=3D"0" class=3D""><span class=3D"">14:24:26.807934</span></s=
pan> [9524/9556]: Receiving data from client ... (in thread_manage_clients(=
) at main.c:4407)<br>DEBUG1 - <span tabindex=3D"0" class=3D""><span class=
=3D"">14:24:26.807955</span></span> [9524/9556]: Processing client command =
13 (in process_client_msg() at main.c:2989)<br>DEBUG1 - <span tabindex=3D"0=
" class=3D""><span class=3D"">14:24:26.807962</span></span> [9524/9556]: Co=
unting number of available session for UID 0 GID 0 (in lttng_sessions_count=
() at main.c:2958)<br>DEBUG1 - <span tabindex=3D"0" class=3D""><span class=
=3D"">14:24:26.807970</span></span> [9524/9556]: Getting all available sess=
ion for UID 0 GID 0 (in cmd_list_lttng_sessions() at cmd.c:2783)<br>DEBUG1 =
- <span tabindex=3D"0" class=3D""><span class=3D"">14:24:26.807978</span></=
span> [9524/9556]: Sending response (size: 4392, retcode: Success) (in thre=
ad_manage_clients() at main.c:4456)<br>DEBUG1 - <span tabindex=3D"0" class=
=3D""><span class=3D"">14:24:26.807999</span></span> [9524/9556]: Clean com=
mand context structure (in clean_command_ctx() at main.c:829)<br>DEBUG1 - <=
span tabindex=3D"0" class=3D""><span class=3D"">14:24:26.808006</span></spa=
n> [9524/9556]: Accepting client command ... (in thread_manage_clients() at=
 main.c:4310)<br>Trace directory: /root/lttng-traces/auto-20160323-142131<b=
r></b></i><br><br><br><br>We are using tracef() in our application.<br><br>=
<br><i><b>#include &lt;lttng/tracef.h&gt;<br><br>tracef(&quot;my message, m=
y integer: %d&quot;, 0x1234);<br></b></i><br><br><i>lttng list --userspace<=
br>DEBUG1 - <span tabindex=3D"0" class=3D""><span class=3D"">14:21:17.74786=
7</span></span> [9524/9556]: Wait for client response (in thread_manage_cli=
ents() at main.c:4362)<br>DEBUG1 - <span tabindex=3D"0" class=3D""><span cl=
ass=3D"">14:21:17.747921</span></span> [9524/9556]: Receiving data from cli=
ent ... (in thread_manage_clients() at main.c:4407)<br>DEBUG1 - <span tabin=
dex=3D"0" class=3D""><span class=3D"">14:21:17.747943</span></span> [9524/9=
556]: Processing client command 14 (in process_client_msg() at main.c:2989)=
<br>DEBUG2 - <span tabindex=3D"0" class=3D""><span class=3D"">14:21:17.7485=
21</span></span> [9524/9556]: Reallocating event list from 32 to 64 entries=
 (in ust_app_list_events() at ust-app.c:3502)<br>DEBUG2 - <span tabindex=3D=
"0" class=3D""><span class=3D"">14:21:17.748623</span></span> [9524/9556]: =
UST app list events done (35 events) (in ust_app_list_events() at ust-app.c=
:3543)<br>DEBUG1 - <span tabindex=3D"0" class=3D""><span class=3D"">14:21:1=
7.748638</span></span> [9524/9556]: Sending response (size: 20456, retcode:=
 Success) (in thread_manage_clients() at main.c:4456)<br>DEBUG1 - <span tab=
index=3D"0" class=3D""><span class=3D"">14:21:17.748663</span></span> [9524=
/9556]: Clean command context structure (in clean_command_ctx() at main.c:8=
29)<br>DEBUG1 - <span tabindex=3D"0" class=3D""><span class=3D"">14:21:17.7=
48670</span></span> [9524/9556]: Accepting client command ... (in thread_ma=
nage_clients() at main.c:4310)<br>UST events:<br>-------------<br><br>PID: =
11876 - Name: &lt;process_name&gt;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_=
ust_cyg_profile_fast:func_exit (loglevel: TRACE_DEBUG_FUNCTION (12)) (type:=
 tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_cyg_profile_fast:f=
unc_entry (loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_cyg_profile:func_exit (loglevel: TRAC=
E_DEBUG_FUNCTION (12)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 lttng_ust_cyg_profile:func_entry (loglevel: TRACE_DEBUG_FUNCTION (12)) (ty=
pe: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_dl:dlclose (log=
level: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 lttng_ust_dl:dlopen (loglevel: TRACE_DEBUG_LINE (13)) (type: trac=
epoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_libc:posix_memalign (lo=
glevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 lttng_ust_libc:memalign (loglevel: TRACE_DEBUG_LINE (13)) (type: =
tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_libc:realloc (logle=
vel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 lttng_ust_libc:calloc (loglevel: TRACE_DEBUG_LINE (13)) (type: trace=
point)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_libc:free (loglevel: TRA=
CE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lt=
tng_ust_libc:malloc (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_pthread:pthread_mutex_unlock (log=
level: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 lttng_ust_pthread:pthread_mutex_trylock (loglevel: TRACE_DEBUG_LI=
NE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_pth=
read:pthread_mutex_lock_acq (loglevel: TRACE_DEBUG_LINE (13)) (type: tracep=
oint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_pthread:pthread_mutex_loc=
k_req (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (1=
4)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog=
:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (log=
level: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEBUG_UNI=
T (11)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_trac=
elog:TRACE_DEBUG_MODULE (loglevel: TRACE_DEBUG_MODULE (10)) (type: tracepoi=
nt)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG_PROCES=
S (loglevel: TRACE_DEBUG_PROCESS (9)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel: TRACE_DEB=
UG_PROGRAM (8)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_=
ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel: TRACE_DEBUG_SYSTEM (7)) (type: t=
racepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_INFO =
(loglevel: TRACE_INFO (6)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 lttng_ust_tracelog:TRACE_NOTICE (loglevel: TRACE_NOTICE (5)) (type: =
tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_WARN=
ING (loglevel: TRACE_WARNING (4)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (type: =
tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_CRIT=
 (loglevel: TRACE_CRIT (2)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 lttng_ust_tracelog:TRACE_ALERT (loglevel: TRACE_ALERT (1)) (type: tr=
acepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_EMERG =
(loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type: tracepoin=
t)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_statedump:end (loglevel: TRA=
CE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lt=
tng_ust_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoin=
t)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_statedump:start (loglevel: T=
RACE_DEBUG_LINE (13)) (type: tracepoint)<br><br></i><br><br><br><br>Kindly =
help us in fixing this issue.<br></div></div></div><div class=3D"gmail_extr=
a"><br clear=3D"all"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><=
font face=3D"courier new, monospace"><font size=3D"2"><span lang=3D"hi"><sp=
an title=3D"Click for alternate translations">Regards,<br>Aditya Dogra<br><=
/span></span>&quot;When the going gets tough, the tough get going&quot;</fo=
nt></font><br></div></div></div>
<br><div class=3D"gmail_quote">On Mon, Mar 28, 2016 at 3:38 PM, Vijay Anand=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:vjanandr85@gmail.com" target=3D"_b=
lank">vjanandr85@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:=
verdana,sans-serif;font-size:small;color:#0000ff">Just to add, we are runni=
ng running a 32 bit application on a 64 bit machine. We have built 32bit ve=
rsions of both the sessiond and the consumerd.</div><div class=3D"gmail_def=
ault" style=3D"font-family:verdana,sans-serif;font-size:small;color:#0000ff=
">Could anyone please point us on how do go about debugging this ?</div></d=
iv><div class=3D"gmail_extra"><br clear=3D"all"><div><div><div dir=3D"ltr">=
<font face=3D"verdana, sans-serif" color=3D"#0000ff">Regards,</font><div><f=
ont face=3D"verdana, sans-serif" color=3D"#0000ff">Vijay</font></div></div>=
</div></div><div><div class=3D"h5">
<br><div class=3D"gmail_quote">On Wed, Mar 23, 2016 at 6:10 PM, Prashanth R=
aghavendra <span dir=3D"ltr">&lt;<a href=3D"mailto:prashanth.raghavendra@gm=
ail.com" target=3D"_blank">prashanth.raghavendra@gmail.com</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><di=
v><div><div>Hi Jeremie,<br><br></div>We upgraded to LTTNG 2.7.<br><br><i><b=
>lttng (LTTng Trace Control) 2.7.1 - Herbe =C3=A0 D=C3=A9tourne - v2.7.1<br=
></b></i><br><br></div>Facing some issues when we do &quot;lttng start&quot=
;. <br><i><br>DEBUG1 - 14:22:18.457697 [9524/9556]: Wait for client respons=
e (in thread_manage_clients() at main.c:4362)<br>DEBUG1 - 14:22:18.457754 [=
9524/9556]: Receiving data from client ... (in thread_manage_clients() at m=
ain.c:4407)<br>DEBUG1 - 14:22:18.457776 [9524/9556]: Processing client comm=
and 16 (in process_client_msg() at main.c:2989)<br>DEBUG1 - 14:22:18.457782=
 [9524/9556]: Getting session auto-20160323-142131 by name (in process_clie=
nt_msg() at main.c:3076)<br>DEBUG2 - 14:22:18.457788 [9524/9556]: Trying to=
 find session by name auto-20160323-142131 (in session_find_by_name() at se=
ssion.c:172)<br>DEBUG1 - 14:22:18.457797 [9524/9556]: Starting all UST trac=
es (in ust_app_start_trace_all() at ust-app.c:4592)<br>DEBUG1 - 14:22:18.45=
7804 [9524/9556]: Starting tracing for ust app pid 11876 (in ust_app_start_=
trace() at ust-app.c:4205)<br>DEBUG3 - 14:22:18.457811 [9524/9556]: mkdir()=
 recursive /root/lttng-traces/auto-20160323-142131 with mode 504 for uid 0 =
and gid 0 (in run_as_mkdir_recursive() at runas.c:468)<br>DEBUG1 - 14:22:18=
.457821 [9524/9556]: Using run_as worker (in run_as() at runas.c:449)<br>DE=
BUG3 - 14:22:18.457871 [9524/9556]: Buffer registry per UID find id: 2, ABI=
: 32, uid: 499 (in buffer_reg_uid_find() at buffer-registry.c:204)<br>DEBUG=
3 - 14:22:18.457885 [9524/9556]: Created hashtable size 4 at 0xf4233240 of =
type 1 (in lttng_ht_new() at hashtable.c:136)<br>DEBUG3 - 14:22:18.457893 [=
9524/9556]: Created hashtable size 4 at 0xf4233318 of type 0 (in lttng_ht_n=
ew() at hashtable.c:136)<br>DEBUG3 - 14:22:18.457899 [9524/9556]: UST app c=
hannel metadata allocated (in alloc_ust_app_channel() at ust-app.c:967)<br>=
DEBUG2 - 14:22:18.457906 [9524/9556]: Asking UST consumer for channel (in a=
sk_channel_creation() at ust-consumer.c:121)<br>DEBUG3 - 14:22:18.457914 [9=
524/9556]: mkdir() recursive /root/lttng-traces/auto-20160323-142131/ust/ui=
d/499/32-bit with mode 504 for uid 0 and gid 0 (in run_as_mkdir_recursive()=
 at runas.c:468)<br>DEBUG1 - 14:22:18.457921 [9524/9556]: Using run_as work=
er (in run_as() at runas.c:449)<br>DEBUG2 - 14:22:18.458130 [9524/9556]: US=
T ask channel 6 successfully done with 1 stream(s) (in ask_channel_creation=
() at ust-consumer.c:216)<br>DEBUG2 - 14:22:18.458139 [9524/9556]: Consumer=
 setup metadata channel key 6 (in consumer_setup_metadata() at consumer.c:1=
236)<br>DEBUG2 - 14:22:18.458176 [9524/9556]: UST metadata with key 6 creat=
ed for app pid 11876 (in create_ust_app_metadata() at ust-app.c:3133)<br>DE=
BUG3 - 14:22:18.458183 [9524/9556]: UST app deleting channel metadata (in d=
elete_ust_app_channel() at ust-app.c:391)<br>DEBUG3 - 14:22:18.458276 [9524=
/9560]: [ust-thread] Manage notify return from poll on 3 fds (in ust_thread=
_manage_notify() at ust-thread.c:76)<br>DEBUG3 - 14:22:18.458289 [9524/9560=
]: UST app receiving notify from sock 33 (in ust_app_recv_notify() at ust-a=
pp.c:5289)<br>DEBUG2 - 14:22:18.458297 [9524/9560]: UST app ustctl register=
 channel received (in ust_app_recv_notify() at ust-app.c:5343)<br>DEBUG3 - =
14:22:18.458309 [9524/9560]: Buffer registry per UID find id: 2, ABI: 32, u=
id: 499 (in buffer_reg_uid_find() at buffer-registry.c:204)<br>Error: Error=
 starting tracing for app pid: 11876 (ret: -1024)<br>DEBUG3 - 14:22:22.4537=
69 [9524/9560]: UST registry channel finding key 0 (in ust_registry_channel=
_find() at ust-registry.c:490)<br>DEBUG1 - 14:22:22.453780 [9524/9556]: Sen=
ding response (size: 16, retcode: Success) (in thread_manage_clients() at m=
ain.c:4456)<br>DEBUG3 - 14:22:22.453787 [9524/9560]: Append to metadata: &q=
uot;stream {<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D 0;<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event.header :=3D struct event_head=
er_compact;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet.context :=
=3D struct packet_context;<br>&quot; (in lttng_metadata_printf() at ust-met=
adata.c:175)<br>DEBUG1 - 14:22:22.453811 [9524/9556]: Clean command context=
 structure (in clean_command_ctx() at main.c:829)<br>DEBUG3 - 14:22:22.4538=
13 [9524/9560]: Append to metadata: &quot;};<br><br>&quot; (in lttng_metada=
ta_printf() at ust-metadata.c:175)<br>DEBUG1 - 14:22:22.453821 [9524/9556]:=
 Accepting client command ... (in thread_manage_clients() at main.c:4310)<b=
r><b>DEBUG3 - 14:22:22.453829 [9524/9560]: UST app replying to register cha=
nnel key 0 with id 0, type: 1, ret: 0 (in reply_ust_register_channel() at u=
st-app.c:5155)<br>DEBUG3 - 14:22:22.453839 [9524/9560]: UST app reply chann=
el failed. Application died (in reply_ust_register_channel() at ust-app.c:5=
162)<br>DEBUG1 - 14:22:22.453851 [9524/9560]: UST app notify socket unregis=
ter 33 (in ust_app_notify_sock_unregister() at ust-app.c:5417)<br>Tracing s=
tarted for session auto-20160323-142131</b><br>DEBUG3 - 14:22:22.453860 [95=
24/9560]: [ust-thread] Manage notify polling (in ust_thread_manage_notify()=
 at ust-thread.c:69)<br>DEBUG3 - 14:22:22.453865 [9524/9526]: [ht-thread] R=
eturning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:74)<br=
>DEBUG3 - 14:22:22.453882 [9524/9526]: [ht-thread] Polling. (in thread_ht_c=
leanup() at ht-cleanup.c:67)<br>DEBUG3 - 14:22:22.453888 [9524/9526]: [ht-t=
hread] Returning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.=
c:74)<br>DEBUG3 - 14:22:22.453895 [9524/9526]: [ht-thread] Polling. (in thr=
ead_ht_cleanup() at ht-cleanup.c:67)<br></i><br><br><br></div>We believe th=
at due to the above issue, no traces are created.<br><br><br><i><b>lttng vi=
ew<br>DEBUG1 - 14:24:26.807884 [9524/9556]: Wait for client response (in th=
read_manage_clients() at main.c:4362)<br>DEBUG1 - 14:24:26.807934 [9524/955=
6]: Receiving data from client ... (in thread_manage_clients() at main.c:44=
07)<br>DEBUG1 - 14:24:26.807955 [9524/9556]: Processing client command 13 (=
in process_client_msg() at main.c:2989)<br>DEBUG1 - 14:24:26.807962 [9524/9=
556]: Counting number of available session for UID 0 GID 0 (in lttng_sessio=
ns_count() at main.c:2958)<br>DEBUG1 - 14:24:26.807970 [9524/9556]: Getting=
 all available session for UID 0 GID 0 (in cmd_list_lttng_sessions() at cmd=
.c:2783)<br>DEBUG1 - 14:24:26.807978 [9524/9556]: Sending response (size: 4=
392, retcode: Success) (in thread_manage_clients() at main.c:4456)<br>DEBUG=
1 - 14:24:26.807999 [9524/9556]: Clean command context structure (in clean_=
command_ctx() at main.c:829)<br>DEBUG1 - 14:24:26.808006 [9524/9556]: Accep=
ting client command ... (in thread_manage_clients() at main.c:4310)<br>Trac=
e directory: /root/lttng-traces/auto-20160323-142131<br></b></i><br><br><br=
><br></div>We are using tracef() in our application.<br><br><br><i><b>#incl=
ude &lt;lttng/tracef.h&gt;<br><br>tracef(&quot;my message, my integer: %d&q=
uot;, 0x1234);<br></b></i><br><br><i>lttng list --userspace<br>DEBUG1 - 14:=
21:17.747867 [9524/9556]: Wait for client response (in thread_manage_client=
s() at main.c:4362)<br>DEBUG1 - 14:21:17.747921 [9524/9556]: Receiving data=
 from client ... (in thread_manage_clients() at main.c:4407)<br>DEBUG1 - 14=
:21:17.747943 [9524/9556]: Processing client command 14 (in process_client_=
msg() at main.c:2989)<br>DEBUG2 - 14:21:17.748521 [9524/9556]: Reallocating=
 event list from 32 to 64 entries (in ust_app_list_events() at ust-app.c:35=
02)<br>DEBUG2 - 14:21:17.748623 [9524/9556]: UST app list events done (35 e=
vents) (in ust_app_list_events() at ust-app.c:3543)<br>DEBUG1 - 14:21:17.74=
8638 [9524/9556]: Sending response (size: 20456, retcode: Success) (in thre=
ad_manage_clients() at main.c:4456)<br>DEBUG1 - 14:21:17.748663 [9524/9556]=
: Clean command context structure (in clean_command_ctx() at main.c:829)<br=
>DEBUG1 - 14:21:17.748670 [9524/9556]: Accepting client command ... (in thr=
ead_manage_clients() at main.c:4310)<br>UST events:<br>-------------<br><br=
>PID: 11876 - Name: &lt;process_name&gt;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
lttng_ust_cyg_profile_fast:func_exit (loglevel: TRACE_DEBUG_FUNCTION (12)) =
(type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_cyg_profile_=
fast:func_entry (loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)<br=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_cyg_profile:func_exit (loglevel: =
TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 lttng_ust_cyg_profile:func_entry (loglevel: TRACE_DEBUG_FUNCTION (12=
)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_dl:dlclos=
e (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 lttng_ust_dl:dlopen (loglevel: TRACE_DEBUG_LINE (13)) (type=
: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_libc:posix_memali=
gn (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 lttng_ust_libc:memalign (loglevel: TRACE_DEBUG_LINE (13)) (=
type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_libc:realloc =
(loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 lttng_ust_libc:calloc (loglevel: TRACE_DEBUG_LINE (13)) (type:=
 tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_libc:free (logleve=
l: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 lttng_ust_libc:malloc (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoi=
nt)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_pthread:pthread_mutex_unloc=
k (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 lttng_ust_pthread:pthread_mutex_trylock (loglevel: TRACE_DE=
BUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_u=
st_pthread:pthread_mutex_lock_acq (loglevel: TRACE_DEBUG_LINE (13)) (type: =
tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_pthread:pthread_mut=
ex_lock_req (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DE=
BUG (14)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tr=
acelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint=
)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG_FUNCTION=
 (loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEB=
UG_UNIT (11)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_us=
t_tracelog:TRACE_DEBUG_MODULE (loglevel: TRACE_DEBUG_MODULE (10)) (type: tr=
acepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG_=
PROCESS (loglevel: TRACE_DEBUG_PROCESS (9)) (type: tracepoint)<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel: TRA=
CE_DEBUG_PROGRAM (8)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel: TRACE_DEBUG_SYSTEM (7)) (t=
ype: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE=
_INFO (loglevel: TRACE_INFO (6)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_NOTICE (loglevel: TRACE_NOTICE (5)) (=
type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRAC=
E_WARNING (loglevel: TRACE_WARNING (4)) (type: tracepoint)<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (=
type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRAC=
E_CRIT (loglevel: TRACE_CRIT (2)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_ALERT (loglevel: TRACE_ALERT (1)) (ty=
pe: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TRACE_=
EMERG (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type: tra=
cepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_statedump:end (logleve=
l: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 lttng_ust_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13)) (type: tra=
cepoint)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_statedump:start (logle=
vel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br><br></i><br><br><br><br><=
/div><div>Kindly help us in fixing this issue.<br><br></div><div><br><br><b=
r></div>Regards,<br></div>Prashanth <br></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Mon, Feb 15, 2016 at 6:20 PM, Prashanth Rag=
havendra <span dir=3D"ltr">&lt;<a href=3D"mailto:prashanth.raghavendra@gmai=
l.com" target=3D"_blank">prashanth.raghavendra@gmail.com</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><div>=
Hi Jeremie,<br><br></div>Thanks for the clarification.<br></div>We will try=
 with the latest version.<br><br><br></div>Regards,<br></div>Prashanth<br><=
/div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Fri, Feb 12, 2016 at 10:10 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"lt=
r">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">=
jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span>On Fri, Feb 12, 2016 at 8:57 AM, Prashanth Raghavendra<=
br>
&lt;<a href=3D"mailto:prashanth.raghavendra@gmail.com" target=3D"_blank">pr=
ashanth.raghavendra@gmail.com</a>&gt; wrote:<br>
&gt; Greetings,<br>
&gt;<br>
&gt; We are trying to use lttng for tracing our application code (userspace=
).<br>
&gt;<br>
&gt; Host OS:=C2=A0 WR5.0.1.13 Linux<br>
&gt; Lttng-tools version 2.1.0, 32-bit=C2=A0 (lttng: ELF 32-bit LSB executa=
ble, Intel<br>
&gt; 80386)<br>
&gt; Babeltrace version 1.0.0<br>
&gt;<br>
<br>
</span>Hi,<br>
<br>
Unfortunately, both of these versions have been unsupported for a long time=
.<br>
Let us know if the problem still occurs with the latest LTTng and<br>
Babeltrace releases.<br>
<br>
Regards,<br>
J=C3=A9r=C3=A9mie<br>
<div><div><br>
&gt; Logged in as root.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; When we start the lttng-sessiond, it gets stuck at &quot;Accepting app=
lication<br>
&gt; registration=E2=80=9D.<br>
&gt;<br>
&gt; Linux(debug)# /isan/lib/lttng-sessiond -vvv --no-kernel<br>
&gt; DEBUG3: Creating LTTng run directory: /var/run/lttng [in<br>
&gt; create_lttng_rundir() at main.c:3683]<br>
&gt; DEBUG2: Kernel consumer err path: /var/run/lttng/kconsumerd/error [in =
main()<br>
&gt; at main.c:3931]<br>
&gt; DEBUG2: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command [i=
n<br>
&gt; main() at main.c:3933]<br>
&gt; DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond [in ma=
in()<br>
&gt; at main.c:3986]<br>
&gt; DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond [in=
<br>
&gt; main() at main.c:3987]<br>
&gt; DEBUG1: LTTng run directory path: /var/run/lttng [in main() at main.c:=
3988]<br>
&gt; DEBUG2: UST consumer 32 bits err path: /var/run/lttng/ustconsumerd32/e=
rror<br>
&gt; [in main() at main.c:3997]<br>
&gt; DEBUG2: UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/c=
ommand<br>
&gt; [in main() at main.c:3999]<br>
&gt; DEBUG2: UST consumer 64 bits err path: /var/run/lttng/ustconsumerd64/e=
rror<br>
&gt; [in main() at main.c:4008]<br>
&gt; DEBUG2: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/c=
ommand<br>
&gt; [in main() at main.c:4010]<br>
&gt; DEBUG3: Created hashtable size 4 at 0x88d7080 of type 1 [in lttng_ht_n=
ew()<br>
&gt; at hashtable.c:96]<br>
&gt; DEBUG3: Created hashtable size 4 at 0x88d7370 of type 1 [in lttng_ht_n=
ew()<br>
&gt; at hashtable.c:96]<br>
&gt; DEBUG2: Creating consumer directory: /var/run/lttng/kconsumerd [in<br>
&gt; set_consumer_sockets() at main.c:3725]<br>
&gt; DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd64 [in=
<br>
&gt; set_consumer_sockets() at main.c:3725]<br>
&gt; DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd32 [in=
<br>
&gt; set_consumer_sockets() at main.c:3725]<br>
&gt; DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT [in<br>
&gt; set_signal_handler() at main.c:3817]<br>
&gt; DEBUG3: Session daemon client socket 8 and application socket 9 create=
d [in<br>
&gt; init_daemon_socket() at main.c:3587]<br>
&gt; Warning: No tracing group detected<br>
&gt; DEBUG1: epoll set max size is 3243642 [in compat_epoll_set_max_size() =
at<br>
&gt; compat-epoll.c:224]<br>
&gt; DEBUG1: Command subsystem initialized [in cmd_init() at cmd.c:2423]<br=
>
&gt; DEBUG1: [thread] Manage health check started [in thread_manage_health(=
) at<br>
&gt; main.c:2944]<br>
&gt; DEBUG1: [thread] Manage client started [in thread_manage_clients() at<=
br>
&gt; main.c:3138]<br>
&gt; DEBUG1: [thread] Dispatch UST command started [in<br>
&gt; thread_dispatch_ust_registration() at main.c:1295]<br>
&gt; DEBUG1: Futex n to 1 prepare done [in futex_nto1_prepare() at futex.c:=
75]<br>
&gt; DEBUG1: Woken up but nothing in the UST command queue [in<br>
&gt; thread_dispatch_ust_registration() at main.c:1305]<br>
&gt; DEBUG1: [thread] Manage application registration started [in<br>
&gt; thread_registration_apps() at main.c:1371]<br>
&gt; DEBUG1: [thread] Manage application started [in thread_manage_apps() a=
t<br>
&gt; main.c:1101]<br>
&gt; DEBUG1: Health check ready [in thread_manage_health() at main.c:2983]<=
br>
&gt; DEBUG1: Accepting client command ... [in thread_manage_clients() at<br=
>
&gt; main.c:3182]<br>
&gt; DEBUG1: Notifying applications of session daemon state: 1 [in<br>
&gt; notify_ust_apps() at main.c:496]<br>
&gt; DEBUG1: Apps thread polling on 2 fds [in thread_manage_apps() at<br>
&gt; main.c:1134]<br>
&gt; DEBUG1: Got the wait shm fd 16 [in get_wait_shm() at shm.c:117]<br>
&gt; DEBUG1: Futex wait update active 1 [in futex_wait_update() at futex.c:=
63]<br>
&gt; DEBUG1: Accepting application registration [in thread_registration_app=
s() at<br>
&gt; main.c:1406]=C2=A0 =3D=3D=3D=C3=A8 Remain struck here<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Because of this, we suspect that the traces from our application are n=
ot<br>
&gt; getting generated. And we get error when we run lttng view:<br>
&gt; (lttng enable-event, start etc went through fine)<br>
&gt;<br>
&gt; Linux(debug)# lttng stop<br>
&gt; Waiting for data availability<br>
&gt; Warning: Tracing already stopped for session auto-20160211-133851<br>
&gt; Linux(debug)# lttng view<br>
&gt; Trace directory: /home/<br>
&gt;<br>
&gt; [error] Cannot open any trace for reading.<br>
&gt;<br>
&gt; [error] opening trace =E2=80=9C/home/&quot; for reading.<br>
&gt;<br>
&gt; [error] none of the specified trace paths could be opened.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Please help us in fixing this issue.<br>
&gt;<br>
&gt; Thank you.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Best Regards,<br>
&gt;<br>
&gt; Prashanth Raghavendra<br>
&gt; Aditya Dogra<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a><br>
&gt;<br>
<span><font color=3D"#888888"><br>
<br><span><font color=3D"#888888">
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</font></span></font></span></blockquote></div><span><font color=3D"#888888=
"><br></font></span></div>
</div></div></blockquote></div><br></div>
</blockquote></div><br></div></div></div>
</blockquote></div><br></div>

--001a113d7ce2c2a341052f1b5faa--

--===============8077253785619279206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8077253785619279206==--
