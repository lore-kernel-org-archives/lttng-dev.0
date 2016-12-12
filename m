From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: core seen in relayd_cleanup()
Date: Mon, 12 Dec 2016 14:39:34 +0530
Message-ID: <CACd+_b5rgKbP+qarXhUD-1-pB=3nLOwPSLrQAYx=hwuxQSj=CA__34731.3609593131$1481533794$gmane$org@mail.gmail.com>
References: <CACd+_b7asL_HVFvZzxq9ungTLqshxTsyxK7-WXJJb-qVop81Ug@mail.gmail.com>
 <CA+jJMxsJmYmWe7h7KjQ96s0x+FAvz1Dp7iinY3Wg=JSzd_O7PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7574366530603761154=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x231.google.com (mail-io0-x231.google.com
 [IPv6:2607:f8b0:4001:c06::231])
 by lists.lttng.org (Postfix) with ESMTPS id 3tccXY6Q71ztW0
 for <lttng-dev@lists.lttng.org>; Mon, 12 Dec 2016 09:11:41 +0000 (UTC)
Received: by mail-io0-x231.google.com with SMTP id p42so164693611ioo.1
 for <lttng-dev@lists.lttng.org>; Mon, 12 Dec 2016 01:09:36 -0800 (PST)
In-Reply-To: <CA+jJMxsJmYmWe7h7KjQ96s0x+FAvz1Dp7iinY3Wg=JSzd_O7PA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7574366530603761154==
Content-Type: multipart/alternative; boundary=001a114c9ccc64475b054372769a

--001a114c9ccc64475b054372769a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Providing the complete info as it was outstanding from my side, took some
time to reproduce this with logs.
This happens when the system is trying to shutdown, apps that are tracing
along with lttng_* processes get a SIGTERM. In this specific scenario, an
app called trace_server and lttng_relayd are being terminated with SIGTERM
almost at the same time. There are a couple of active tracing sessions at
this point.
I have cut out only those logs which are relevant to this issue from the
time the app ( trace_server ) registers with sessiond and have added
comments inline below.
Couldnt attach the complete logs due to mailing size limits.

*####### SESSIOND : App Registration ########*

DEBUG1 - 03:25:04.481119 [20477/20484]: UST registration received with
pid:19671 ppid:1 uid:0 gid:0 sock:81 name:trace_server (version 6.1) (in
thread_registration_apps() at main.c:2306)

DEBUG1 - 03:25:04.481122 [20477/20484]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:123)

DEBUG1 - 03:25:04.481124 [20477/20484]: Accepting application registration
(in thread_registration_apps() at main.c:2192)



DEBUG1 - 03:25:04.494180 [20477/20483]: Dispatching UST registration
pid:19671 ppid:1 uid:0 gid:0 sock:81 name:trace_server (version 6.1) (in
thread_dispatch_ust_registration() at main.c:1950)

DEBUG3 - 03:25:04.494184 [20477/20483]: UST app creating application for
socket 81 (in ust_app_create() at ust-app.c:3294)

DEBUG3 - 03:25:04.494186 [20477/20483]: Created hashtable size 4 at
0x7f66fc01f790 of type 2 (in lttng_ht_new() at hashtable.c:145)

DEBUG3 - 03:25:04.494189 [20477/20483]: Created hashtable size 4 at
0x7f66fc01fbd0 of type 1 (in lttng_ht_new() at hashtable.c:145)

DEBUG3 - 03:25:04.494194 [20477/20483]: Created hashtable size 4 at
0x7f66fc020010 of type 1 (in lttng_ht_new() at hashtable.c:14



DEBUG1 - 03:25:04.498652 [20477/20484]: UST registration received with
pid:19671 ppid:1 uid:0 gid:0 sock:173 name:trace_server (version 6.1) (in
thread_registration_apps() at main.c:2306)

DEBUG1 - 03:25:04.498655 [20477/20484]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:123)

DEBUG1 - 03:25:04.498656 [20477/20484]: Accepting application registration
(in thread_registration_apps() at main.c:2192)



DEBUG1 - 03:25:04.524781 [20477/20483]: Dispatching UST registration
pid:19671 ppid:1 uid:0 gid:0 sock:173 name:trace_server (version 6.1) (in
thread_dispatch_ust_registration() at main.c:1950)

DEBUG3 - 03:25:04.524784 [20477/20483]: UST app notify socket 173 is set
(in thread_dispatch_ust_registration() at main.c:2007)

DEBUG1 - 03:25:04.524788 [20477/20483]: App registered with pid:19671
ppid:1 uid:0 gid:0 sock:81 name:trace_server notify_sock:173 (version 6.1)
(in ust_app_add() at ust-app.c:3383)



DEBUG2 - 03:25:07.156727 [20477/20482]: UST app pid: 19671 session id 0 not
found, creating it (in create_ust_app_session() at ust-app.c:2171)

DEBUG3 - 03:25:07.156733 [20477/20482]: Created hashtable size 4 at
0x7f67040e5420 of type 0 (in lttng_ht_new() at hashtable.c:145)

DEBUG2 - 03:25:07.156742 [20477/20482]: Shadow copy of session handle -1
(in shadow_copy_session() at ust-app.c:1869)

DEBUG3 - 03:25:07.156749 [20477/20482]: Buffer registry per PID find id: 19
(in buffer_reg_pid_find() at buffer-registry.c:317)

DEBUG3 - 03:25:07.156761 [20477/20482]: Created hashtable size 4 at
0x7f67040e7810 of type 2 (in lttng_ht_new() at hashtable.c:145)

DEBUG3 - 03:25:07.156763 [20477/20482]: Buffer registry per PID created
with session id: 19 (in buffer_reg_pid_create() at buffer-registry.c:278)

DEBUG3 - 03:25:07.156775 [20477/20482]: Created hashtable size 4 at
0x7f67040ead00 of type 0 (in lttng_ht_new() at hashtable.c:145)

DEBUG3 - 03:25:07.156778 [20477/20482]: Created hashtable size 4 at
0x7f67040eb140 of type 2 (in lttng_ht_new() at hashtable.c:145)

DEBUG3 - 03:25:07.156814 [20477/20482]: Append to metadata: "/* CTF 1.8 */



" (in lttng_metadata_printf() at ust-metadata.c:179)

DEBUG3 - 03:25:07.156825 [20477/20482]: Append to metadata: "typealias
integer { size =3D 8; align =3D 8; signed =3D false; } :=3D uint8_t;

typealias integer { size =3D 16; align =3D 8; signed =3D false; } :=3D uint=
16_t;

typealias integer { size =3D 32; align =3D 8; signed =3D false; } :=3D uint=
32_t;

typealias integer { size =3D 64; align =3D 8; signed =3D false; } :=3D uint=
64_t;

typealias integer { size =3D 64; align =3D 8; signed =3D false; } :=3D unsi=
gned
long;

typealias integer { size =3D 5; align =3D 1; signed =3D false; } :=3D uint5=
_t;

typealias integer { size =3D 27; align =3D 1; signed =3D false; } :=3D uint=
27_t;

...

...

...

#### REMOVED METADATA PRINTS HERE #####

...

...


DEBUG3 - 03:25:07.156953 [20477/20482]: Buffer registry per PID adding to
global registry with id: 19 (in buffer_reg_pid_add() at
buffer-registry.c:297)

DEBUG3 - 03:25:07.156956 [20477/20482]: UST app buffer registry per PID
created successfully (in setup_buffer_reg_pid() at ust-app.c:2065)

DEBUG2 - 03:25:07.157171 [20477/20482]: UST app session created
successfully with handle 1 (in create_ust_app_session() at ust-app.c:2246)

DEBUG3 - 03:25:07.157178 [20477/20482]: Created hashtable size 4 at
0x7f67040eb7a0 of type 1 (in lttng_ht_new() at hashtable.c:145)

DEBUG3 - 03:25:07.157181 [20477/20482]: Created hashtable size 4 at
0x7f67040ebbe0 of type 0 (in lttng_ht_new() at hashtable.c:145)

DEBUG3 - 03:25:07.157183 [20477/20482]: UST app channel DefaultChannel
allocated (in alloc_ust_app_channel() at ust-app.c:1051)

DEBUG2 - 03:25:07.157185 [20477/20482]: UST app shadow copy of channel
DefaultChannel started (in shadow_copy_channel() at ust-app.c:1794)

DEBUG3 - 03:25:07.157188 [20477/20482]: UST app shadow copy of channel
DefaultChannel done (in shadow_copy_channel() at ust-app.c:1845)

DEBUG1 - 03:25:07.157190 [20477/20482]: UST app creating channel
DefaultChannel with per PID buffers (in create_channel_per_pid() at
ust-app.c:2946)

DEBUG3 - 03:25:07.157192 [20477/20482]: Buffer registry per PID find id: 19
(in buffer_reg_pid_find() at buffer-registry.c:317)

DEBUG3 - 03:25:07.157196 [20477/20482]: Created hashtable size 4 at
0x7f67040ec0a0 of type 0 (in lttng_ht_new() at hashtable.c:145)

DEBUG2 - 03:25:07.157204 [20477/20482]: Asking UST consumer for channel (in
ask_channel_creation() at ust-consumer.c:120)

DEBUG3 - 03:25:07.157212 [20477/20482]: UST registry channel finding key 19
(in ust_registry_channel_find() at ust-registry.c:784)

DEBUG2 - 03:25:07.165001 [20477/20482]: UST ask channel 19 successfully
done with 2 stream(s) (in ask_channel_creation() at ust-consumer.c:215)

DEBUG2 - 03:25:07.165714 [20477/20482]: UST app stream 1 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:330)

DEBUG2 - 03:25:07.165757 [20477/20482]: UST app stream 2 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:330)

DEBUG3 - 03:25:07.165767 [20477/20482]: UST app consumer has no more stream
available (in ust_consumer_get_channel() at ust-consumer.c:313)

DEBUG1 - 03:25:07.165773 [20477/20482]: UST app sending channel
DefaultChannel to UST app sock 81 (in send_channel_pid_to_ust() at
ust-app.c:1623)

DEBUG2 - 03:25:07.165775 [20477/20482]: UST app send channel to sock 81 pid
19671 (name: DefaultChannel, key: 0) (in ust_consumer_send_channel_to_ust()
at ust-consumer.c:436)

DEBUG2 - 03:25:07.166019 [20477/20482]: UST consumer send stream to app 81
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:399)

DEBUG2 - 03:25:07.166057 [20477/20482]: UST consumer send stream to app 81
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:399)

DEBUG2 - 03:25:07.166086 [20477/20482]: UST app create channel
DefaultChannel for PID 19671 completed (in create_ust_app_channel() at
ust-app.c:3086)





                                *########  CONSUMERD : creating
channels


############*

*                                ########  KEY 104 and 106 are nothing but
wait fd's, referred to as streams 37 and 38 below on the RELAYD side.
############*

                                DEBUG1 - 03:25:07.157239 [20706/20713]:
Incoming command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3182)

                                DEBUG1 - 03:25:07.157258 [20706/20713]:
Allocated channel (key 19) (in consumer_allocate_channel() at
consumer.c:1024)

                                DEBUG3 - 03:25:07.157262 [20706/20713]:
Creating channel to ustctl with attr: [overwrite: 0, subbuf_size: 1048576,
num_subbuf: 4, switch_timer_interval: 0, read_timer_interval: 0, output: 0,
type: 0 (in create_ust_channel() at ust-consumer.c:458)

                                DEBUG3 - 03:25:07.164838 [20706/20713]:
Allocated stream DefaultChannel_0 (key 104, chan_key 19 relayd_id 2,
session_id 0 (in consumer_allocate_stream() at consumer.c:608)

                                DEBUG1 - 03:25:07.164852 [20706/20713]: UST
consumer add stream DefaultChannel_0 (key: 104) with relayd id 0 (in
create_ust_streams() at ust-consumer.c:347)

                                DEBUG3 - 03:25:07.164855 [20706/20713]:
Allocated stream DefaultChannel_1 (key 106, chan_key 19 relayd_id 2,
session_id 0 (in consumer_allocate_stream() at consumer.c:608)

                                DEBUG1 - 03:25:07.164857 [20706/20713]: UST
consumer add stream DefaultChannel_1 (key: 106) with relayd id 0 (in
create_ust_streams() at ust-consumer.c:347)

                                DEBUG1 - 03:25:07.164911 [20706/20713]: UST
consumer channel added (key: 19) (in add_channel() at ust-consumer.c:115)

                                DEBUG1 - 03:25:07.164927 [20706/20713]:
received command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3198)

                                DEBUG1 - 03:25:07.165055 [20706/20713]:
Incoming command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3182)

                                DEBUG1 - 03:25:07.165071 [20706/20713]: UST
consumer sending channel DefaultChannel to sessiond (in
send_sessiond_channel() at ust-consumer.c:562)

                                DEBUG1 - 03:25:07.165076 [20706/20713]:
Relayd adding stream for channel name DefaultChannel_0 (in
relayd_add_stream() at relayd.c:252)

                                DEBUG3 - 03:25:07.165148 [20706/20713]:
Relayd sending command 1 of size 4400 (in send_command() at relayd.c:81)

                                DEBUG3 - 03:25:07.165152 [20706/20713]:
Relayd waiting for reply of size 12 (in recv_reply() at relayd.c:101)

                                DEBUG1 - 03:25:07.165510 [20706/20713]:
Relayd stream added successfully with handle 37 (in relayd_add_stream() at
relayd.c:317)

                                DEBUG1 - 03:25:07.165513 [20706/20713]:
Stream DefaultChannel_0 with key 104 sent to relayd id 2 (in
consumer_send_relayd_stream() at consumer.c:811)

                                DEBUG1 - 03:25:07.165516 [20706/20713]:
Relayd adding stream for channel name DefaultChannel_1 (in
relayd_add_stream() at relayd.c:252)

                                DEBUG3 - 03:25:07.165532 [20706/20713]:
Relayd sending command 1 of size 4400 (in send_command() at relayd.c:81)

                                DEBUG3 - 03:25:07.165535 [20706/20713]:
Relayd waiting for reply of size 12 (in recv_reply() at relayd.c:101)

                                DEBUG1 - 03:25:07.165618 [20706/20713]:
Relayd stream added successfully with handle 38 (in relayd_add_stream() at
relayd.c:317)

                                DEBUG1 - 03:25:07.165621 [20706/20713]:
Stream DefaultChannel_1 with key 106 sent to relayd id 2 (in
consumer_send_relayd_stream() at consumer.c:811)

                                DEBUG1 - 03:25:07.165636 [20706/20713]: UST
consumer sending stream 104 to sessiond (in send_sessiond_stream() at
ust-consumer.c:533)

                                DEBUG1 - 03:25:07.165643 [20706/20713]: UST
consumer sending stream 106 to sessiond (in send_sessiond_stream() at
ust-consumer.c:533)

                                DEBUG1 - 03:25:07.165663 [20706/20713]: UST
consumer NULL stream sent to sessiond (in send_sessiond_channel() at
ust-consumer.c:626)

                                DEBUG3 - 03:25:07.165665 [20706/20713]:
Adding consumer stream 104 (in consumer_add_data_stream() at consumer.c:634=
)

                                DEBUG3 - 03:25:07.165682 [20706/20713]:
Adding consumer stream 106 (in consumer_add_data_stream() at consumer.c:634=
)

                                DEBUG1 - 03:25:07.165688 [20706/20713]:
received command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3198)



                                                                *#######
RELAYD :  logs for creation of streams 37 and 38           #######*

                                                                DEBUG3 -
03:25:09.165076 [19663/19666]: Receiving data of size 84 for stream id 37
seqnum 0 (in relay_process_data() at main.c:2289)

                                                                DEBUG1 -
03:25:09.165079 [19663/19666]: handle_index_data: stream 37 net_seq_num 0
data offset 0 (in handle_index_data() at main.c:2178)

                                                                DEBUG3 -
03:25:09.165081 [19663/19666]: Finding index for stream id 37 and seq_num 0
(in relay_index_get_by_id_or_create() at index.c:133)

                                                                DEBUG2 -
03:25:09.165084 [19663/19666]: Creating relay index for stream id 37 and
seqnum 0 (in relay_index_create() at index.c:44)

                                                                DEBUG2 -
03:25:09.165087 [19663/19666]: Adding relay index with stream id 37 and
seqnum 0 (in relay_index_add_unique() at index.c:81)

                                                                DEBUG2 -
03:25:09.165090 [19663/19666]: Index found or created in HT for stream ID
37 and seqnum 0 (in relay_index_get_by_id_or_create() at index.c:165)

                                                                DEBUG1 -
03:25:09.165203 [19663/19666]: utils_unlink_stream_file
/var/log/lttng-traces/evo-xb49-re0//DefaultSession-20161207-032506//ust/pid=
/
trace_server-19671-20161207-032507/index/DefaultChannel_0_0.idx returns -1
(in utils_unlink_stream_file() at utils.c:830)

                                                                DEBUG2 -
03:25:09.165267 [19663/19666]: Relay wrote 84 bytes to tracefile for stream
id 37 (in relay_process_data() at main.c:2360)

                                                                DEBUG1 -
03:25:09.165278 [19663/19666]: stream put for stream id 37 (in stream_put()
at stream.c:335)

                                                                DEBUG1 -
03:25:09.165280 [19663/19666]: stream put stream id 37 refcount 3 (in
stream_put() at stream.c:352)



                                                                DEBUG3 -
03:25:09.167450 [19663/19666]: Receiving data of size 84 for stream id 38
seqnum 0 (in relay_process_data() at main.c:2289)

                                                                DEBUG1 -
03:25:09.167481 [19663/19666]: handle_index_data: stream 38 net_seq_num 0
data offset 0 (in handle_index_data() at main.c:2178)

                                                                DEBUG3 -
03:25:09.167484 [19663/19666]: Finding index for stream id 38 and seq_num 0
(in relay_index_get_by_id_or_create() at index.c:133)

                                                                DEBUG2 -
03:25:09.167486 [19663/19666]: Creating relay index for stream id 38 and
seqnum 0 (in relay_index_create() at index.c:44)

                                                                DEBUG2 -
03:25:09.167488 [19663/19666]: Adding relay index with stream id 38 and
seqnum 0 (in relay_index_add_unique() at index.c:81)

                                                                DEBUG2 -
03:25:09.167490 [19663/19666]: Index found or created in HT for stream ID
38 and seqnum 0 (in relay_index_get_by_id_or_create() at index.c:165)

                                                                DEBUG1 -
03:25:09.167507 [19663/19666]: utils_unlink_stream_file
/var/log/lttng-traces/evo-xb49-re0//DefaultSession-20161207-032506//ust/pid=
/
trace_server-19671-20161207-032507/index/DefaultChannel_1_0.idx returns -1
(in utils_unlink_stream_file() at utils.c:830)

                                                                DEBUG2 -
03:25:09.167561 [19663/19666]: Relay wrote 84 bytes to tracefile for stream
id 38 (in relay_process_data() at main.c:2360)

                                                                DEBUG1 -
03:25:09.167571 [19663/19666]: stream put for stream id 38 (in stream_put()
at stream.c:335)

                                                                DEBUG1 -
03:25:09.167573 [19663/19666]: stream put stream id 38 refcount 3 (in
stream_put() at stream.c:352)



*#########  SESSIOND: Start tracing ###########*

*######### Metadata key or channel 92 here is NOT and FD, just another
number ##########*

DEBUG1 - 03:25:07.923556 [20477/20482]: Starting tracing for ust app pid
19671 (in ust_app_start_trace() at ust-app.c:4318)

DEBUG3 - 03:25:07.923560 [20477/20482]: Buffer registry per PID find id: 19
(in buffer_reg_pid_find() at buffer-registry.c:317)

DEBUG3 - 03:25:07.923565 [20477/20482]: Created hashtable size 4 at
0x7f67040a8070 of type 1 (in lttng_ht_new() at hashtable.c:145)

DEBUG3 - 03:25:07.923581 [20477/20482]: Created hashtable size 4 at
0x7f67040a84b0 of type 0 (in lttng_ht_new() at hashtable.c:145)

DEBUG3 - 03:25:07.923584 [20477/20482]: UST app channel metadata allocated
(in alloc_ust_app_channel() at ust-app.c:1051)

DEBUG2 - 03:25:07.923587 [20477/20482]: Asking UST consumer for channel (in
ask_channel_creation() at ust-consumer.c:120)

DEBUG2 - 03:25:07.923704 [20477/20482]: UST ask channel 92 successfully
done with 1 stream(s) (in ask_channel_creation() at ust-consumer.c:215)

DEBUG2 - 03:25:07.923708 [20477/20482]: Consumer setup metadata channel key
92 (in consumer_setup_metadata() at consumer.c:1273)

DEBUG2 - 03:25:07.924027 [20477/20482]: UST metadata with key 92 created
for app pid 19671 (in create_ust_app_metadata() at ust-app.c:3245)

DEBUG3 - 03:25:07.924031 [20477/20482]: UST app deleting channel metadata
(in delete_ust_app_channel() at ust-app.c:457)

DEBUG3 - 03:25:07.924033 [20477/20482]: Buffer registry per PID find id: 19
(in buffer_reg_pid_find() at buffer-registry.c:317)

DEBUG3 - 03:25:07.924036 [20477/20482]: UST registry channel finding key 92
(in ust_registry_channel_find() at ust-registry.c:784)





                *######### CONSUMERD : adding metadata channel
####################*

*                ##########   378 is the FD for this channel
####################*

                                DEBUG1 - 03:25:07.923604 [20706/20713]:
Incoming command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3182)

                                DEBUG1 - 03:25:07.923623 [20706/20713]:
Allocated channel (key 92) (in consumer_allocate_channel() at
consumer.c:1024)

                                DEBUG3 - 03:25:07.923626 [20706/20713]:
Creating channel to ustctl with attr: [overwrite: 0, subbuf_size: 4096,
num_subbuf: 2, switch_timer_interval: 0, read_timer_interval: 0, output: 0,
type: 1 (in create_ust_channel() at ust-consumer.c:458)

                                DEBUG3 - 03:25:07.923683 [20706/20713]:
Allocated stream metadata (key 378, chan_key 92 relayd_id 2, session_id 0
(in consumer_allocate_stream() at consumer.c:608)

                                DEBUG1 - 03:25:07.923687 [20706/20713]: UST
consumer add stream metadata (key: 378) with relayd id 0 (in
create_ust_streams() at ust-consumer.c:347)

                                DEBUG1 - 03:25:07.923690 [20706/20713]:
Allocated metadata cache of 4096 bytes (in consumer_metadata_cache_allocate=
()
at consumer-metadata-cache.c:198)

                                DEBUG1 - 03:25:07.923694 [20706/20713]: UST
consumer channel added (key: 92) (in add_channel() at ust-consumer.c:115)

                                DEBUG1 - 03:25:07.923697 [20706/20713]:
received command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3198)

                                DEBUG1 - 03:25:07.923721 [20706/20713]:
Incoming command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3182)

                                DEBUG1 - 03:25:07.923731 [20706/20713]: UST
consumer setup metadata key 92 (in setup_metadata() at ust-consumer.c:876)

                                DEBUG1 - 03:25:07.923734 [20706/20713]:
Relayd adding stream for channel name metadata (in relayd_add_stream() at
relayd.c:252)

                                DEBUG3 - 03:25:07.923759 [20706/20713]:
Relayd sending command 1 of size 4400 (in send_command() at relayd.c:81)

                                DEBUG3 - 03:25:07.923762 [20706/20713]:
Relayd waiting for reply of size 12 (in recv_reply() at relayd.c:101)

                                DEBUG1 - 03:25:07.923884 [20706/20713]:
Relayd stream added successfully with handle 165 (in relayd_add_stream() at
relayd.c:317)

                                DEBUG1 - 03:25:07.923888 [20706/20713]:
Stream metadata with key 378 sent to relayd id 2 (in
consumer_send_relayd_stream() at consumer.c:811)

                                DEBUG1 - 03:25:07.923890 [20706/20713]:
Relayd sending streams sent. (in relayd_streams_sent() at relayd.c:336)

                                DEBUG3 - 03:25:07.923903 [20706/20713]:
Relayd sending command 16 of size 24 (in send_command() at relayd.c:81)

                                DEBUG3 - 03:25:07.923906 [20706/20713]:
Relayd waiting for reply of size 4 (in recv_reply() at relayd.c:101)

                                DEBUG1 - 03:25:07.923947 [20706/20713]:
Relayd streams sent success (in relayd_streams_sent() at relayd.c:369)

                                DEBUG1 - 03:25:07.923950 [20706/20713]: All
streams sent relayd id 2 (in consumer_send_relayd_streams_sent() at
consumer.c:849)

                                DEBUG3 - 03:25:07.923952 [20706/20713]:
Adding metadata stream 378 to hash table (in consumer_add_metadata_stream()
at consumer.c:2115)



                                                                *##########=
####
RELAYD : adding metadata channel handle id 165  #######################*

                                                                DEBUG3 -
03:25:07.918301 [19663/19666]: Relayd worker thread polling... (in
relay_thread_worker() at main.c:2481)

                                                                DEBUG3 -
03:25:07.923820 [19663/19666]: Created hashtable size 4 at 0x7f1d4404ceb0
of type 2 (in lttng_ht_new() at hashtable.c:145)

                                                                DEBUG1 -
03:25:07.923855 [19663/19666]: Tracefile /var/log/lttng-traces/evo-
xb49-re0//DefaultSession-20161207-032506//ust/pid/
trace_server-19671-20161207-032507/metadata created (in stream_create() at
stream.c:151)

                                                                DEBUG1 -
03:25:07.923859 [19663/19666]: Relay new stream added metadata with ID 165
(in stream_create() at stream.c:177)









*#######   SESSIOND : closing for trace_server   #######*

DEBUG1 - 03:39:11.176955 [20477/20482]: Flushing session buffers for all
ust apps (in ust_app_flush_session() at ust-app.c:4583)

.....

*###### app going down at this point is picked up by sessiond   ######*

DEBUG1 - 03:55:51.236181 [20477/20485]: PID 19671 unregistering with sock
81 (in ust_app_unregister() at ust-app.c:3437)

DEBUG1 - 03:55:51.236190 [20477/20485]: Flushing app session buffers for
ust app pid 19671 (in ust_app_flush_app_session() at ust-app.c:4522)

DEBUG2 - 03:55:51.236196 [20477/20485]: Consumer flush channel key 383 (in
consumer_flush_channel() at consumer.c:1174)

DEBUG3 - 03:55:51.236791 [20477/20485]: Buffer registry per PID find id:
201 (in buffer_reg_pid_find() at buffer-registry.c:317)

DEBUG3 - 03:55:51.236798 [20477/20485]: No metadata to push for metadata
key 456 (in ust_app_push_metadata() at ust-app.c:587)

DEBUG2 - 03:55:51.236802 [20477/20485]: Consumer close metadata channel key
456 (in consumer_close_metadata() at consumer.c:1240)

DEBUG1 - 03:55:51.237113 [20477/20485]: Flushing app session buffers for
ust app pid 19671 (in ust_app_flush_app_session() at ust-app.c:4522)

DEBUG2 - 03:55:51.237120 [20477/20485]: Consumer flush channel key 19 (in
consumer_flush_channel() at consumer.c:1174)

DEBUG3 - 03:55:51.237386 [20477/20485]: Buffer registry per PID find id: 19
(in buffer_reg_pid_find() at buffer-registry.c:317)

DEBUG3 - 03:55:51.237391 [20477/20485]: No metadata to push for metadata
key 92 (in ust_app_push_metadata() at ust-app.c:587)

DEBUG2 - 03:55:51.237393 [20477/20485]: Consumer close metadata channel key
92 (in consumer_close_metadata() at consumer.c:1240)



                                *###### CONSUMERD : getting request to
close  ###########*

                                DEBUG1 - 03:55:51.237169 [20706/20713]:
Incoming command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3182)

                                DEBUG1 - 03:55:51.237179 [20706/20713]: UST
consumer flush channel key 19 (in flush_channel() at ust-consumer.c:751)

                                DEBUG1 - 03:55:51.237362 [20706/20713]:
received command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3198)

                                DEBUG1 - 03:55:51.237411 [20706/20713]:
Incoming command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3182)

                                DEBUG1 - 03:55:51.237420 [20706/20713]: UST
consumer close metadata key 92 (in close_metadata() at ust-consumer.c:835)

                                DEBUG1 - 03:55:51.277601 [20706/20713]:
Closing metadata channel key 92 (in lttng_ustconsumer_close_metadata() at
ust-consumer.c:2720)

                                DEBUG1 - 03:55:51.277619 [20706/20713]:
received command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3198)



*                                ##### CONSUMERD : thread 20713 handling
close_metadata is done here , but 20711 got an event for fd 378 associated
with key 92 #####*

*                                ##### consumerd is also polling on 104 and
106, they have not hup|err here, there is a crucial delay  ######*

                                DEBUG1 - 03:55:51.277662 [20706/20711]:
Metadata poll return from wait with 78 fd(s) (in
consumer_thread_metadata_poll() at consumer.c:2274)

                                DEBUG1 - 03:55:51.277664 [20706/20711]:
Metadata event caught in thread (in consumer_thread_metadata_poll() at
consumer.c:2276)

                                DEBUG1 - 03:55:51.277668 [20706/20711]:
Metadata fd 378 is hup|err. (in consumer_thread_metadata_poll() at
consumer.c:2390)

                                DEBUG1 - 03:55:51.277684 [20706/20711]:
Attempting to flush and consume the UST buffers (in
consumer_thread_metadata_poll() at consumer.c:2394)

                                DEBUG1 - 03:55:51.277701 [20706/20711]: In
UST read_subbuffer (wait_fd: 378, name: metadata) (in
lttng_ustconsumer_read_subbuffer() at ust-consumer.c:2439)

                                DEBUG1 - 03:55:51.279107 [20706/20711]:
Relayd sending metadata of size 49 (in relayd_send_metadata() at
relayd.c:459)

                                .....

                                DEBUG3 - 03:55:51.279123 [20706/20711]:
Relayd sending command 6 of size 24 (in send_command() at relayd.c:81)

                                DEBUG2 - 03:55:51.279126 [20706/20711]:
Relayd metadata added successfully (in relayd_send_metadata() at
relayd.c:467)

                                DEBUG1 - 03:55:51.279130 [20706/20711]:
Metadata stream id 165 with padding 4059 written before data (in
write_relayd_metadata_id() at consumer.c:1483)

                                DEBUG1 - 03:55:51.279134 [20706/20711]:
Consumer mmap write() ret 37 (len 37) (in
lttng_consumer_on_read_subbuffer_mmap()
at consumer.c:1661)

                                DEBUG1 - 03:55:51.279140 [20706/20711]: In
UST read_subbuffer (wait_fd: 378, name: metadata) (in
lttng_ustconsumer_read_subbuffer() at ust-consumer.c:2439)

                                DEBUG3 - 03:55:51.279146 [20706/20711]:
Consumer delete metadata stream 378 (in consumer_del_metadata_stream() at
consumer.c:2062)

                                DEBUG1 - 03:55:51.279157 [20706/20711]:
Closing metadata channel key 92 (in lttng_ustconsumer_close_metadata() at
ust-consumer.c:2720)

                                DEBUG1 - 03:55:51.279166 [20706/20711]:
Relayd closing stream id 165 (in relayd_send_close_stream() at relayd.c:594=
)

                                DEBUG3 - 03:55:51.279170 [20706/20711]:
Relayd sending command 7 of size 40 (in send_command() at relayd.c:81)

                                DEBUG3 - 03:55:51.279172 [20706/20711]:
Relayd waiting for reply of size 4 (in recv_reply() at relayd.c:101)

                                DEBUG3 - 03:55:51.289333 [20477/20490]:
Call RCU deleting app PID 19671 (in delete_ust_app_rcu() at ust-app.c:947)

                                DEBUG3 - 03:55:51.289540 [20477/20490]:
Buffer registry per PID find id: 19 (in buffer_reg_pid_find() at
buffer-registry.c:317)

                                DEBUG3 - 03:55:51.289551 [20477/20490]: UST
app deleting channel DefaultChannel (in delete_ust_app_channel() at
ust-app.c:457)

                                DEBUG3 - 03:55:51.289568 [20477/20490]:
Buffer registry per PID find id: 19 (in buffer_reg_pid_find() at
buffer-registry.c:317)

                                DEBUG3 - 03:55:51.289571 [20477/20490]: UST
registry channel finding key 19 (in ust_registry_channel_find() at
ust-registry.c:784)

                                DEBUG3 - 03:55:51.289613 [20477/20490]:
Session 0 found by id. (in session_find_by_id() at session.c:312)

                                DEBUG3 - 03:55:51.289616 [20477/20490]:
Consumer discarded events id 0 (in consumer_get_discarded_events() at
consumer.c:1428)

                                .....

                                DEBUG1 - 03:55:51.289658 [20706/20713]:
Incoming command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3182)

                                DEBUG1 - 03:55:51.289700 [20706/20713]: UST
consumer discarded events command for session id 0 (in
lttng_ustconsumer_recv_cmd() at ust-consumer.c:1769)

                                DEBUG1 - 03:55:51.323528 [20706/20711]:
Relayd close stream id 165 successfully (in relayd_send_close_stream() at
relayd.c:623)

                                DEBUG1 - 03:55:51.323587 [20706/20711]:
Consumer delete channel key 92 (in consumer_del_channel() at consumer.c:359=
)





*                                                                #####
RELAYD : GOT SIGTERM and is going down, cleaning streams here #######*

*                                                                #####
RELAYD : trying to close streams 37 and 38. 37 got closed, 38 has data
pending !! #####################*

                                                                DEBUG1 -
03:55:51.653672 [19663/19666]: Trying to close stream 37 (in
try_stream_close() at stream.c:360)

                                                                DEBUG1 -
03:55:51.653675 [19663/19666]: stream_unpublish:: lttng_ht_del() : stream
0x7f1d440125b0 refcount 1 stream 37 trace 19 session 1 (in
stream_unpublish() at stream.c:252)

                                                                DEBUG1 -
03:55:51.653677 [19663/19666]: Succeeded in closing stream 37 (in
try_stream_close() at stream.c:431)

                                                                DEBUG1 -
03:55:51.653678 [19663/19666]: stream put for stream id 37 (in stream_put()
at stream.c:335)

                                                                DEBUG1 -
03:55:51.653680 [19663/19666]: stream put stream id 37 refcount 1 (in
stream_put() at stream.c:352)

                                                                DEBUG1 -
03:55:51.653681 [19663/19666]: Releasing stream id 37 (in stream_release()
at stream.c:305)

                                                                DEBUG1 -
03:55:51.653687 [19663/19666]: Trying to close stream 38 (in
try_stream_close() at stream.c:360)

                                                                DEBUG1 -
03:55:51.653690 [19663/19666]: closing stream 38 aborted since it still has
data pending (in try_stream_close() at stream.c:420)









*                                ####### CONSUMERD : errors on fd 104 and
106 detected. Relayd has completely exited at this point. ###########*

                                DEBUG1 - 03:55:51.850362 [20706/20712]: fd
104 is hup|err|nval. Attempting flush and read. (in
consumer_thread_data_poll() at consumer.c:2661)

                                DEBUG1 - 03:55:51.850371 [20706/20712]:
Polling fd 104 tells it has hung up. (in consumer_thread_data_poll() at
consumer.c:2672)

                                DEBUG1 - 03:55:51.850375 [20706/20712]: fd
106 is hup|err|nval. Attempting flush and read. (in
consumer_thread_data_poll() at consumer.c:2661)

                                DEBUG1 - 03:55:51.850377 [20706/20712]:
Polling fd 106 tells it has hung up. (in consumer_thread_data_poll() at
consumer.c:2672)



*                                ###### RELAYD has waited for the
"data_pending" to get completed for the stream 106 and gone down, now
consumerd realizes that the app is going down             ######*



                                DEBUG1 - 03:55:51.859249 [20706/20712]:
Normal read on fd 104 (in consumer_thread_data_poll() at consumer.c:2636)

                                DEBUG1 - 03:55:51.859253 [20706/20712]: In
UST read_subbuffer (wait_fd: 104, name: DefaultChannel_0) (in
lttng_ustconsumer_read_subbuffer() at ust-consumer.c:2439)

                                DEBUG1 - 03:55:51.859256 [20706/20712]:
Reserving sub buffer failed (everything is normal, it is due to
concurrency) [ret: -11] (in lttng_ustconsumer_read_subbuffer() at
ust-consumer.c:2490)



                                DEBUG1 - 03:55:51.859478 [20706/20712]:
Delete flag set to data stream 106 (in update_endpoint_status_by_netidx()
at consumer.c:446)



                                DEBUG1 - 03:55:51.859546 [20706/20712]:
Normal read on fd 106 (in consumer_thread_data_poll() at consumer.c:2636)

                                DEBUG1 - 03:55:51.859548 [20706/20712]: In
UST read_subbuffer (wait_fd: 106, name: DefaultChannel_1) (in
lttng_ustconsumer_read_subbuffer() at ust-consumer.c:2439)

                                DEBUG1 - 03:55:51.859550 [20706/20712]:
Reserving sub buffer failed (everything is normal, it is due to
concurrency) [ret: -11] (in lttng_ustconsumer_read_subbuffer() at
ust-consumer.c:2490)





                                DEBUG1 - 03:55:51.859577 [20706/20712]:
Polling fd 104 tells it has hung up. (in consumer_thread_data_poll() at
consumer.c:2672)

                                DEBUG1 - 03:55:51.859582 [20706/20712]:
Consumer stream destroy monitored key: 104 (in destroy_close_stream() at
consumer-stream.c:268)

                                DEBUG1 - 03:55:51.859592 [20706/20712]:
Polling fd 106 tells it has hung up. (in consumer_thread_data_poll() at
consumer.c:2672)

                                DEBUG1 - 03:55:51.859596 [20706/20712]:
Consumer stream destroy monitored key: 106 (in destroy_close_stream() at
consumer-stream.c:268)

                                DEBUG1 - 03:55:51.859602 [20706/20712]:
Consumer delete channel key 19 (in consumer_del_channel() at consumer.c:359=
)



                                DEBUG1 - 03:55:51.868988 [20706/20711]:
Closing metadata channel key 104 (in lttng_ustconsumer_close_metadata() at
ust-consumer.c:2720)

                                DEBUG1 - 03:55:51.869001 [20706/20711]:
Consumer delete channel key 104 (in consumer_del_channel() at
consumer.c:359)



                                DEBUG1 - 03:55:51.869347 [20706/20711]:
Closing metadata channel key 106 (in lttng_ustconsumer_close_metadata() at
ust-consumer.c:2720)

                                DEBUG1 - 03:55:51.869359 [20706/20711]:
Consumer delete channel key 106 (in consumer_del_channel() at
consumer.c:359)





                                DEBUG1 - 03:55:52.179253 [20706/20713]:
Incoming command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3182)

                                DEBUG1 - 03:55:52.179487 [20706/20713]: UST
consumer close metadata key 104 (in close_metadata() at ust-consumer.c:835)

                                DEBUG1 - 03:55:52.179517 [20706/20713]: UST
consumer close metadata 104 not found (in close_metadata() at
ust-consumer.c:845)



                                DEBUG1 - 03:55:52.229354 [20706/20713]:
Incoming command on sock (in consumer_thread_sessiond_poll() at
consumer.c:3182)

                                DEBUG1 - 03:55:52.229443 [20706/20713]: UST
consumer close metadata key 106 (in close_metadata() at ust-consumer.c:835)

                                DEBUG1 - 03:55:52.229469 [20706/20713]: UST
consumer close metadata 106 not found (in close_metadata() at
ust-consumer.c:845)



Regards,

Aravind.

On Wed, Nov 30, 2016 at 1:10 AM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On 29 November 2016 at 14:19, Aravind HT <aravind.ht@gmail.com> wrote:
> > Hi,
> >
> >
> > I was in the processes of upgrading to 2.8.1 and see the below relayd
> core.
> > I am trying to get the logs for this but is proving hard to reproduce
> this
> > scenario with full logs enabled and also as this is happening in a
> complex
> > environment, not sure why relayd is exiting.
> >
> > For the meantime, from https://lwn.net/Articles/573432/  , I see that
> > cds_lfht_destroy() may fail in case the ht is not empty. Should the
> assert()
> > be there in relayd_cleanup() or do you know what can cause/simulate thi=
s
> > crash ?
>
> Hi Aravind,
>
> The assert() is there because, at that point, the streams should have
> been "torn down" cleanly before exiting. It is a check to ensure we
> don't leak the object and, more importantly, properly close the trace
> on disk.
>
> I am not sure what can cause the stream to be "dangling" at this
> point. Are you killing the relay daemon or is it closing on its own
> (presumably after encountering an error)?.
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
> > Ive tried killing relayd with SIGINT, SIGTERM when sesions are being
> active
> > and that doesnt reproduce this.
> >
> > 55      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> > [Current thread is 1 (Thread 0x7fd7e7c0e980 (LWP 29366))]
> > (gdb) info threads
> >   Id   Target Id         Frame
> >   2    Thread 0x7fd7e1b1c700 (LWP 29375) 0x00007fd7e6701996 in _int_fre=
e
> > (av=3D<optimized out>, p=3D<optimized out>, have_lock=3D0) at malloc.c:=
4059
> > * 1    Thread 0x7fd7e7c0e980 (LWP 29366) 0x00007fd7e66bd367 in __GI_rai=
se
> > (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:55
> > (gdb) bt full
> > #0  0x00007fd7e66bd367 in __GI_raise (sig=3Dsig@entry=3D6) at
> > ../sysdeps/unix/sysv/linux/raise.c:55
> >         resultvar =3D 0
> >         pid =3D 29366
> >         selftid =3D 29366
> > #1  0x00007fd7e66c033a in __GI_abort () at abort.c:89
> >         save_stage =3D 2
> >         act =3D {__sigaction_handler =3D {sa_handler =3D 0x4, sa_sigact=
ion =3D
> 0x4},
> > sa_mask =3D {__val =3D {5, 48, 140732823353744, 3924933264, 0, 0, 0,
> > 21474836480, 140732823353896, 140565261773123,
> >               140732823353696, 140565261807824, 140565261789000,
> > 140732823354144, 140565282869248, 140565261789000}}, sa_flags =3D 44622=
01,
> > sa_restorer =3D 0x4416c0 <__PRETTY_FUNCTION__.5555>}
> >         sigs =3D {__val =3D {32, 0 <repeats 15 times>}}
> > #2  0x00007fd7e66b644d in __assert_fail_base (fmt=3D0x7fd7e67f2748
> "%s%s%s:%u:
> > %s%sAssertion `%s' failed.\n%n", assertion=3Dassertion@entry=3D0x441679
> "!ret",
> > file=3Dfile@entry=3D0x4415da "hashtable.c",
> >     line=3Dline@entry=3D162, function=3Dfunction@entry=3D0x4416c0
> > <__PRETTY_FUNCTION__.5555> "lttng_ht_destroy") at assert.c:92
> >         str =3D 0x65b310 ""
> >         total =3D 4096
> > #3  0x00007fd7e66b6502 in __GI___assert_fail (assertion=3D0x441679 "!re=
t",
> > file=3D0x4415da "hashtable.c", line=3D162, function=3D0x4416c0
> > <__PRETTY_FUNCTION__.5555> "lttng_ht_destroy") at assert.c:101
> > No locals.
> > #4  0x0000000000422f17 in lttng_ht_destroy (ht=3D0x65a0e0) at
> hashtable.c:162
> >         ret =3D -1
> >         __PRETTY_FUNCTION__ =3D "lttng_ht_destroy"
> > #5  0x000000000040803b in relayd_cleanup () at main.c:497
> >         __func__ =3D "relayd_cleanup"
> > #6  0x000000000040ec4c in main (argc=3D5, argv=3D0x7ffee9f1bd68) at
> main.c:2939
> >         ret =3D 0
> >         retval =3D 0
> >         status =3D 0x0
> >         __func__ =3D "main"
> >
> > (gdb) f 4
> > #4  0x0000000000422f17 in lttng_ht_destroy (ht=3D0x65a0e0) at
> hashtable.c:162
> > 162     hashtable.c: No such file or directory.
> > (gdb) p *ht->ht
> > $1 =3D {max_nr_buckets =3D 9223372036854775808, mm =3D 0x7fd7e6e50920
> > <cds_lfht_mm_order>,
> > flavor =3D 0x7fd7e77b6340 <rcu_flavor_memb>, count =3D -1024, resize_mu=
tex =3D
> > {__data =3D {
> > __lock =3D 0, __count =3D 0, __owner =3D 0, __nusers =3D 0, __kind =3D =
0, __spins
> =3D 0,
> >       __elision =3D 0, __list =3D {__prev =3D 0x0, __next =3D 0x0}},
> >     __size =3D '\000' <repeats 39 times>, __align =3D 0}, resize_attr =
=3D 0x0,
> >   in_progress_resize =3D 0, in_progress_destroy =3D 1, resize_target =
=3D 2048,
> >   resize_initiated =3D 0, flags =3D 3, min_alloc_buckets_order =3D 0,
> > min_nr_alloc_buckets =3D 1,
> >   split_count =3D 0x65b170, .., bucket_at =3D 0x7fd7e6c4e080 <bucket_at=
>, {
> >     tbl_order =3D {0x65b280, 0x65b2a0, 0x65b2c0, 0x7fd7c40008c0,
> > 0x7fd7c4000910,
> >       0x7fd7c40009a0, 0x7fd7c4000ab0, 0x7fd7c4001070, 0x7fd7c4001480,
> > 0x7fd7c4001c90,
> >       0x7fd7c4003350, 0x7fd7c4005360, 0x0 <repeats 52 times>}, tbl_chun=
k
> =3D
> > 0x65af60,
> >     tbl_mmap =3D 0x65b280}}
> >
> >
> > Regards,
> > Aravind.
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a114c9ccc64475b054372769a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">Hi,</span><div style=3D"f=
ont-size:12.8px"><br></div><div style=3D"font-size:12.8px">Providing the co=
mplete info as it was outstanding from my side, took some time to reproduce=
 this with logs.<br>This happens when the system is trying to shutdown, app=
s that are tracing along with lttng_* processes get a SIGTERM. In this spec=
ific scenario, an app called trace_server and lttng_relayd are being termin=
ated with SIGTERM almost at the same time. There are a couple of active tra=
cing sessions at this point.</div><div style=3D"font-size:12.8px">I have cu=
t out only those logs which are relevant to this issue from the time the ap=
p ( trace_server ) registers with sessiond and have added comments inline b=
elow.</div><div style=3D"font-size:12.8px">Couldnt attach the complete logs=
 due to mailing size limits.</div><div style=3D"font-size:12.8px"><br></div=
><div style=3D"font-size:12.8px"><p class=3D"MsoNormal"><b><span style=3D"f=
ont-size:8pt;font-family:&quot;book antiqua&quot;,serif">####### SESSIOND :=
 App Registration ########</span></b></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG1 - 03:2=
5:04.481119 [20477/20484]: UST registration received with pid:19671 ppid:1 =
uid:0 gid:0 sock:81 name:trace_server (version 6.1) (in thread_registration=
_apps() at main.c:2306)</span></p><p class=3D"MsoNormal"><span style=3D"fon=
t-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG1 - 03:25:04.48=
1122 [20477/20484]: Futex n to 1 wake done (in futex_nto1_wake() at futex.c=
:123)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fa=
mily:&quot;book antiqua&quot;,serif">DEBUG1 - 03:25:04.481124 [20477/20484]=
: Accepting application registration (in thread_registration_apps() at main=
.c:2192)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font=
-family:&quot;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNor=
mal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,seri=
f">DEBUG1 - 03:25:04.494180 [20477/20483]: Dispatching UST registration pid=
:19671 ppid:1 uid:0 gid:0 sock:81 name:trace_server (version 6.1) (in threa=
d_dispatch_ust_<wbr>registration() at main.c:1950)</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,=
serif">DEBUG3 - 03:25:04.494184 [20477/20483]: UST app creating application=
 for socket 81 (in ust_app_create() at ust-app.c:3294)</span></p><p class=
=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&=
quot;,serif">DEBUG3 - 03:25:04.494186 [20477/20483]: Created hashtable size=
 4 at 0x7f66fc01f790 of type 2 (in lttng_ht_new() at hashtable.c:145)</span=
></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;=
book antiqua&quot;,serif">DEBUG3 - 03:25:04.494189 [20477/20483]: Created h=
ashtable size 4 at 0x7f66fc01fbd0 of type 1 (in lttng_ht_new() at hashtable=
.c:145)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-=
family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:04.494194 [20477/2048=
3]: Created hashtable size 4 at 0x7f66fc020010 of type 1 (in lttng_ht_new()=
 at hashtable.c:14</span></p><p class=3D"MsoNormal"><span style=3D"font-siz=
e:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0</span></p><p class=
=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&=
quot;,serif">DEBUG1 - 03:25:04.498652 [20477/20484]: UST registration recei=
ved with pid:19671 ppid:1 uid:0 gid:0 sock:173 name:trace_server (version 6=
.1) (in thread_registration_apps() at main.c:2306)</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,=
serif">DEBUG1 - 03:25:04.498655 [20477/20484]: Futex n to 1 wake done (in f=
utex_nto1_wake() at futex.c:123)</span></p><p class=3D"MsoNormal"><span sty=
le=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG1 - 03=
:25:04.498656 [20477/20484]: Accepting application registration (in thread_=
registration_apps() at main.c:2192)</span></p><p class=3D"MsoNormal"><span =
style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0</=
span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&q=
uot;book antiqua&quot;,serif">DEBUG1 - 03:25:04.524781 [20477/20483]: Dispa=
tching UST registration pid:19671 ppid:1 uid:0 gid:0 sock:173 name:trace_se=
rver (version 6.1) (in thread_dispatch_ust_<wbr>registration() at main.c:19=
50)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:04.524784 [20477/20483]: =
UST app notify socket 173 is set (in thread_dispatch_ust_<wbr>registration(=
) at main.c:2007)</span></p><p class=3D"MsoNormal"><span style=3D"font-size=
:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG1 - 03:25:04.524788 [=
20477/20483]: App registered with pid:19671 ppid:1 uid:0 gid:0 sock:81 name=
:trace_server notify_sock:173 (version 6.1) (in ust_app_add() at ust-app.c:=
3383)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fa=
mily:&quot;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNormal=
"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=
DEBUG2 - 03:25:07.156727 [20477/20482]: UST app pid: 19671 session id 0 not=
 found, creating it (in create_ust_app_session() at ust-app.c:2171)</span><=
/p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;bo=
ok antiqua&quot;,serif">DEBUG3 - 03:25:07.156733 [20477/20482]: Created has=
htable size 4 at 0x7f67040e5420 of type 0 (in lttng_ht_new() at hashtable.c=
:145)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fa=
mily:&quot;book antiqua&quot;,serif">DEBUG2 - 03:25:07.156742 [20477/20482]=
: Shadow copy of session handle -1 (in shadow_copy_session() at ust-app.c:1=
869)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fam=
ily:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:07.156749 [20477/20482]:=
 Buffer registry per PID find id: 19 (in buffer_reg_pid_find() at buffer-re=
gistry.c:317)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt=
;font-family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:07.156761 [2047=
7/20482]: Created hashtable size 4 at 0x7f67040e7810 of type 2 (in lttng_ht=
_new() at hashtable.c:145)</span></p><p class=3D"MsoNormal"><span style=3D"=
font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:07=
.156763 [20477/20482]: Buffer registry per PID created with session id: 19 =
(in buffer_reg_pid_create() at buffer-registry.c:278)</span></p><p class=3D=
"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quo=
t;,serif">DEBUG3 - 03:25:07.156775 [20477/20482]: Created hashtable size 4 =
at 0x7f67040ead00 of type 0 (in lttng_ht_new() at hashtable.c:145)</span></=
p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;boo=
k antiqua&quot;,serif">DEBUG3 - 03:25:07.156778 [20477/20482]: Created hash=
table size 4 at 0x7f67040eb140 of type 2 (in lttng_ht_new() at hashtable.c:=
145)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fam=
ily:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:07.156814 [20477/20482]:=
 Append to metadata: &quot;/* CTF 1.8 */</span></p><p class=3D"MsoNormal"><=
span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">&quot; (in lttng_metadata_printf() at us=
t-metadata.c:179)</span></p><p class=3D"MsoNormal"><span style=3D"font-size=
:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:07.156825 [=
20477/20482]: Append to metadata: &quot;typealias integer { size =3D 8; ali=
gn =3D 8; signed =3D false; } :=3D uint8_t;</span></p><p class=3D"MsoNormal=
"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=
typealias integer { size =3D 16; align =3D 8; signed =3D false; } :=3D uint=
16_t;</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fa=
mily:&quot;book antiqua&quot;,serif">typealias integer { size =3D 32; align=
 =3D 8; signed =3D false; } :=3D uint32_t;</span></p><p class=3D"MsoNormal"=
><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">t=
ypealias integer { size =3D 64; align =3D 8; signed =3D false; } :=3D uint6=
4_t;</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fam=
ily:&quot;book antiqua&quot;,serif">typealias integer { size =3D 64; align =
=3D 8; signed =3D false; } :=3D unsigned long;</span></p><p class=3D"MsoNor=
mal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,seri=
f">typealias integer { size =3D 5; align =3D 1; signed =3D false; } :=3D ui=
nt5_t;</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-f=
amily:&quot;book antiqua&quot;,serif">typealias integer { size =3D 27; alig=
n =3D 1; signed =3D false; } :=3D uint27_t;</span></p><p class=3D"MsoNormal=
"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=
...</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">...</span></p><p class=3D"MsoNormal"><sp=
an style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">...</=
span></p><p class=3D"MsoNormal">#### REMOVED METADATA PRINTS HERE #####</p>=
<p class=3D"MsoNormal">...</p><p class=3D"MsoNormal">...</p><p class=3D"Mso=
Normal"><br></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fa=
mily:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:07.156953 [20477/20482]=
: Buffer registry per PID adding to global registry with id: 19 (in buffer_=
reg_pid_add() at buffer-registry.c:297)</span></p><p class=3D"MsoNormal"><s=
pan style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBU=
G3 - 03:25:07.156956 [20477/20482]: UST app buffer registry per PID created=
 successfully (in setup_buffer_reg_pid() at ust-app.c:2065)</span></p><p cl=
ass=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiq=
ua&quot;,serif">DEBUG2 - 03:25:07.157171 [20477/20482]: UST app session cre=
ated successfully with handle 1 (in create_ust_app_session() at ust-app.c:2=
246)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fam=
ily:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:07.157178 [20477/20482]:=
 Created hashtable size 4 at 0x7f67040eb7a0 of type 1 (in lttng_ht_new() at=
 hashtable.c:145)</span></p><p class=3D"MsoNormal"><span style=3D"font-size=
:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:25:07.157181 [=
20477/20482]: Created hashtable size 4 at 0x7f67040ebbe0 of type 0 (in lttn=
g_ht_new() at hashtable.c:145)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:2=
5:07.157183 [20477/20482]: UST app channel DefaultChannel allocated (in all=
oc_ust_app_channel() at ust-app.c:1051)</span></p><p class=3D"MsoNormal"><s=
pan style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBU=
G2 - 03:25:07.157185 [20477/20482]: UST app shadow copy of channel DefaultC=
hannel started (in shadow_copy_channel() at ust-app.c:1794)</span></p><p cl=
ass=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiq=
ua&quot;,serif">DEBUG3 - 03:25:07.157188 [20477/20482]: UST app shadow copy=
 of channel DefaultChannel done (in shadow_copy_channel() at ust-app.c:1845=
)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family=
:&quot;book antiqua&quot;,serif">DEBUG1 - 03:25:07.157190 [20477/20482]: US=
T app creating channel DefaultChannel with per PID buffers (in create_chann=
el_per_pid() at ust-app.c:2946)</span></p><p class=3D"MsoNormal"><span styl=
e=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:=
25:07.157192 [20477/20482]: Buffer registry per PID find id: 19 (in buffer_=
reg_pid_find() at buffer-registry.c:317)</span></p><p class=3D"MsoNormal"><=
span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEB=
UG3 - 03:25:07.157196 [20477/20482]: Created hashtable size 4 at 0x7f67040e=
c0a0 of type 0 (in lttng_ht_new() at hashtable.c:145)</span></p><p class=3D=
"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quo=
t;,serif">DEBUG2 - 03:25:07.157204 [20477/20482]: Asking UST consumer for c=
hannel (in ask_channel_creation() at ust-consumer.c:120)</span></p><p class=
=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&=
quot;,serif">DEBUG3 - 03:25:07.157212 [20477/20482]: UST registry channel f=
inding key 19 (in ust_registry_channel_find() at ust-registry.c:784)</span>=
</p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;b=
ook antiqua&quot;,serif">DEBUG2 - 03:25:07.165001 [20477/20482]: UST ask ch=
annel 19 successfully done with 2 stream(s) (in ask_channel_creation() at u=
st-consumer.c:215)</span></p><p class=3D"MsoNormal"><span style=3D"font-siz=
e:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG2 - 03:25:07.165714 =
[20477/20482]: UST app stream 1 received successfully (in ust_consumer_get_=
channel() at ust-consumer.c:330)</span></p><p class=3D"MsoNormal"><span sty=
le=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG2 - 03=
:25:07.165757 [20477/20482]: UST app stream 2 received successfully (in ust=
_consumer_get_channel() at ust-consumer.c:330)</span></p><p class=3D"MsoNor=
mal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,seri=
f">DEBUG3 - 03:25:07.165767 [20477/20482]: UST app consumer has no more str=
eam available (in ust_consumer_get_channel() at ust-consumer.c:313)</span><=
/p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;bo=
ok antiqua&quot;,serif">DEBUG1 - 03:25:07.165773 [20477/20482]: UST app sen=
ding channel DefaultChannel to UST app sock 81 (in send_channel_pid_to_ust(=
) at ust-app.c:1623)</span></p><p class=3D"MsoNormal"><span style=3D"font-s=
ize:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG2 - 03:25:07.16577=
5 [20477/20482]: UST app send channel to sock 81 pid 19671 (name: DefaultCh=
annel, key: 0) (in ust_consumer_send_channel_to_<wbr>ust() at ust-consumer.=
c:436)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-f=
amily:&quot;book antiqua&quot;,serif">DEBUG2 - 03:25:07.166019 [20477/20482=
]: UST consumer send stream to app 81 (in ust_consumer_send_stream_to_<wbr>=
ust() at ust-consumer.c:399)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG2 - 03:2=
5:07.166057 [20477/20482]: UST consumer send stream to app 81 (in ust_consu=
mer_send_stream_to_<wbr>ust() at ust-consumer.c:399)</span></p><p class=3D"=
MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot=
;,serif">DEBUG2 - 03:25:07.166086 [20477/20482]: UST app create channel Def=
aultChannel for PID 19671 completed (in create_ust_app_channel() at ust-app=
.c:3086)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font=
-family:&quot;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNor=
mal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,seri=
f">=C2=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;fon=
t-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wb=
r>=C2=A0=C2=A0<b>########=C2=A0 CONSUMERD : creating channels=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ############</b></span></p><p class=3D"MsoNo=
rmal"><b><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,=
serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 ########=C2=A0 KEY 104 a=
nd 106 are nothing but wait fd&#39;s, referred to as streams 37 and 38 belo=
w on the RELAYD side. ############</span></b></p><p class=3D"MsoNormal"><sp=
an style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.157239 [20706/2071=
3]: Incoming command on sock (in consumer_thread_sessiond_poll(<wbr>) at co=
nsumer.c:3182)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8p=
t;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.157258 [20706/20713]: Allocated channel (k=
ey 19) (in consumer_allocate_channel() at consumer.c:1024)</span></p><p cla=
ss=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqu=
a&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:25:07.=
157262 [20706/20713]: Creating channel to ustctl with attr: [overwrite: 0, =
subbuf_size: 1048576, num_subbuf: 4, switch_timer_interval: 0, read_timer_i=
nterval: 0, output: 0, type: 0 (in create_ust_channel() at ust-consumer.c:4=
58)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0 DEBUG3 - 03:25:07.164838 [20706/20713]: Allocated stream DefaultChannel=
_0 (key 104, chan_key 19 relayd_id 2, session_id 0 (in consumer_allocate_st=
ream() at consumer.c:608)</span></p><p class=3D"MsoNormal"><span style=3D"f=
ont-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.164852 [20706/20713]: UST consume=
r add stream DefaultChannel_0 (key: 104) with relayd id 0 (in create_ust_st=
reams() at ust-consumer.c:347)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:25:07.164855 [20706/20713]: Alloc=
ated stream DefaultChannel_1 (key 106, chan_key 19 relayd_id 2, session_id =
0 (in consumer_allocate_stream() at consumer.c:608)</span></p><p class=3D"M=
soNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;=
,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.164857=
 [20706/20713]: UST consumer add stream DefaultChannel_1 (key: 106) with re=
layd id 0 (in create_ust_streams() at ust-consumer.c:347)</span></p><p clas=
s=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua=
&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.=
164911 [20706/20713]: UST consumer channel added (key: 19) (in add_channel(=
) at ust-consumer.c:115)</span></p><p class=3D"MsoNormal"><span style=3D"fo=
nt-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.164927 [20706/20713]: received co=
mmand on sock (in consumer_thread_sessiond_poll(<wbr>) at consumer.c:3198)<=
/span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&=
quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 =
DEBUG1 - 03:25:07.165055 [20706/20713]: Incoming command on sock (in consum=
er_thread_sessiond_poll(<wbr>) at consumer.c:3182)</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,=
serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.165071=
 [20706/20713]: UST consumer sending channel DefaultChannel to sessiond (in=
 send_sessiond_channel() at ust-consumer.c:562)</span></p><p class=3D"MsoNo=
rmal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,ser=
if">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.165076 [2=
0706/20713]: Relayd adding stream for channel name DefaultChannel_0 (in rel=
ayd_add_stream() at relayd.c:252)</span></p><p class=3D"MsoNormal"><span st=
yle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:25:07.165148 [20706/20713]: Re=
layd sending command 1 of size 4400 (in send_command() at relayd.c:81)</spa=
n></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot=
;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3=
 - 03:25:07.165152 [20706/20713]: Relayd waiting for reply of size 12 (in r=
ecv_reply() at relayd.c:101)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.165510 [20706/20713]: Relay=
d stream added successfully with handle 37 (in relayd_add_stream() at relay=
d.c:317)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font=
-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wb=
r>=C2=A0 DEBUG1 - 03:25:07.165513 [20706/20713]: Stream DefaultChannel_0 wi=
th key 104 sent to relayd id 2 (in consumer_send_relayd_stream() at consume=
r.c:811)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font=
-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wb=
r>=C2=A0 DEBUG1 - 03:25:07.165516 [20706/20713]: Relayd adding stream for c=
hannel name DefaultChannel_1 (in relayd_add_stream() at relayd.c:252)</span=
></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;=
book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3=
 - 03:25:07.165532 [20706/20713]: Relayd sending command 1 of size 4400 (in=
 send_command() at relayd.c:81)</span></p><p class=3D"MsoNormal"><span styl=
e=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:25:07.165535 [20706/20713]: Relay=
d waiting for reply of size 12 (in recv_reply() at relayd.c:101)</span></p>=
<p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book =
antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:=
25:07.165618 [20706/20713]: Relayd stream added successfully with handle 38=
 (in relayd_add_stream() at relayd.c:317)</span></p><p class=3D"MsoNormal">=
<span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.165621 [20706/2=
0713]: Stream DefaultChannel_1 with key 106 sent to relayd id 2 (in consume=
r_send_relayd_stream() at consumer.c:811)</span></p><p class=3D"MsoNormal">=
<span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.165636 [20706/2=
0713]: UST consumer sending stream 104 to sessiond (in send_sessiond_stream=
() at ust-consumer.c:533)</span></p><p class=3D"MsoNormal"><span style=3D"f=
ont-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.165643 [20706/20713]: UST consume=
r sending stream 106 to sessiond (in send_sessiond_stream() at ust-consumer=
.c:533)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-=
family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=
=C2=A0 DEBUG1 - 03:25:07.165663 [20706/20713]: UST consumer NULL stream sen=
t to sessiond (in send_sessiond_channel() at ust-consumer.c:626)</span></p>=
<p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book =
antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:=
25:07.165665 [20706/20713]: Adding consumer stream 104 (in consumer_add_dat=
a_stream() at consumer.c:634)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:25:07.165682 [20706/20713]: Addin=
g consumer stream 106 (in consumer_add_data_stream() at consumer.c:634)</sp=
an></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quo=
t;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEB=
UG1 - 03:25:07.165688 [20706/20713]: received command on sock (in consumer_=
thread_sessiond_poll(<wbr>) at consumer.c:3198)</span></p><p class=3D"MsoNo=
rmal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,ser=
if">=C2=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;fo=
nt-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wb=
r>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0<b>####### RE=
LAYD :=C2=A0 logs for creation of streams 37 and 38=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #######</b></span></p><p class=3D"MsoN=
ormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,se=
rif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wb=
r>=C2=A0=C2=A0=C2=A0 DEBUG3 - 03:25:09.165076 [19663/19666]: Receiving data=
 of size 84 for stream id 37 seqnum 0 (in relay_process_data() at main.c:22=
89)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG1 - 03:25:09.165079=
 [19663/19666]: handle_index_data: stream 37 net_seq_num 0 data offset 0 (i=
n handle_index_data() at main.c:2178)</span></p><p class=3D"MsoNormal"><spa=
n style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=
=A0=C2=A0 DEBUG3 - 03:25:09.165081 [19663/19666]: Finding index for stream =
id 37 and seq_num 0 (in relay_index_get_by_id_or_<wbr>create() at index.c:1=
33)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG2 - 03:25:09.165084=
 [19663/19666]: Creating relay index for stream id 37 and seqnum 0 (in rela=
y_index_create() at index.c:44)</span></p><p class=3D"MsoNormal"><span styl=
e=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=
=A0 DEBUG2 - 03:25:09.165087 [19663/19666]: Adding relay index with stream =
id 37 and seqnum 0 (in relay_index_add_unique() at index.c:81)</span></p><p=
 class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book an=
tiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG2 - 03:25:09.165090 [19663/19666]:=
 Index found or created in HT for stream ID 37 and seqnum 0 (in relay_index=
_get_by_id_or_<wbr>create() at index.c:165)</span></p><p class=3D"MsoNormal=
"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0=C2=A0=C2=A0 DEBUG1 - 03:25:09.165203 [19663/19666]: utils_unlink_stream=
_file /var/log/lttng-traces/evo-<wbr>xb49-re0//DefaultSession-<wbr>20161207=
-032506//ust/pid/<wbr>trace_server-19671-20161207-<wbr>032507/index/Default=
Channel_0_<wbr>0.idx returns -1 (in utils_unlink_stream_file() at utils.c:8=
30)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG2 - 03:25:09.165267=
 [19663/19666]: Relay wrote 84 bytes to tracefile for stream id 37 (in rela=
y_process_data() at main.c:2360)</span></p><p class=3D"MsoNormal"><span sty=
le=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=
=C2=A0 DEBUG1 - 03:25:09.165278 [19663/19666]: stream put for stream id 37 =
(in stream_put() at stream.c:335)</span></p><p class=3D"MsoNormal"><span st=
yle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=
=C2=A0 DEBUG1 - 03:25:09.165280 [19663/19666]: stream put stream id 37 refc=
ount 3 (in stream_put() at stream.c:352)</span></p><p class=3D"MsoNormal"><=
span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG3 - 03:25:09.167450=
 [19663/19666]: Receiving data of size 84 for stream id 38 seqnum 0 (in rel=
ay_process_data() at main.c:2289)</span></p><p class=3D"MsoNormal"><span st=
yle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=
=C2=A0 DEBUG1 - 03:25:09.167481 [19663/19666]: handle_index_data: stream 38=
 net_seq_num 0 data offset 0 (in handle_index_data() at main.c:2178)</span>=
</p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;b=
ook antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG3 - 03:25:09.167484 [19663/1=
9666]: Finding index for stream id 38 and seq_num 0 (in relay_index_get_by_=
id_or_<wbr>create() at index.c:133)</span></p><p class=3D"MsoNormal"><span =
style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=
=A0=C2=A0 DEBUG2 - 03:25:09.167486 [19663/19666]: Creating relay index for =
stream id 38 and seqnum 0 (in relay_index_create() at index.c:44)</span></p=
><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book=
 antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG2 - 03:25:09.167488 [19663/1966=
6]: Adding relay index with stream id 38 and seqnum 0 (in relay_index_add_u=
nique() at index.c:81)</span></p><p class=3D"MsoNormal"><span style=3D"font=
-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG2=
 - 03:25:09.167490 [19663/19666]: Index found or created in HT for stream I=
D 38 and seqnum 0 (in relay_index_get_by_id_or_<wbr>create() at index.c:165=
)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family=
:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG1 - 03:25:09.167507 [1=
9663/19666]: utils_unlink_stream_file /var/log/lttng-traces/evo-<wbr>xb49-r=
e0//DefaultSession-<wbr>20161207-032506//ust/pid/<wbr>trace_server-19671-20=
161207-<wbr>032507/index/DefaultChannel_1_<wbr>0.idx returns -1 (in utils_u=
nlink_stream_file() at utils.c:830)</span></p><p class=3D"MsoNormal"><span =
style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=
=A0=C2=A0 DEBUG2 - 03:25:09.167561 [19663/19666]: Relay wrote 84 bytes to t=
racefile for stream id 38 (in relay_process_data() at main.c:2360)</span></=
p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;boo=
k antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG1 - 03:25:09.167571 [19663/1966=
6]: stream put for stream id 38 (in stream_put() at stream.c:335)</span></p=
><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book=
 antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG1 - 03:25:09.167573 [19663/1966=
6]: stream put stream id 38 refcount 3 (in stream_put() at stream.c:352)</s=
pan></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&qu=
ot;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNormal"><b><sp=
an style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">#####=
####=C2=A0 SESSIOND: Start tracing ###########</span></b></p><p class=3D"Ms=
oNormal"><b><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quo=
t;,serif">######### Metadata key or channel 92 here is NOT and FD, just ano=
ther number ##########</span></b></p><p class=3D"MsoNormal"><span style=3D"=
font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG1 - 03:25:07=
.923556 [20477/20482]: Starting tracing for ust app pid 19671 (in ust_app_s=
tart_trace() at ust-app.c:4318)</span></p><p class=3D"MsoNormal"><span styl=
e=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:=
25:07.923560 [20477/20482]: Buffer registry per PID find id: 19 (in buffer_=
reg_pid_find() at buffer-registry.c:317)</span></p><p class=3D"MsoNormal"><=
span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEB=
UG3 - 03:25:07.923565 [20477/20482]: Created hashtable size 4 at 0x7f67040a=
8070 of type 1 (in lttng_ht_new() at hashtable.c:145)</span></p><p class=3D=
"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quo=
t;,serif">DEBUG3 - 03:25:07.923581 [20477/20482]: Created hashtable size 4 =
at 0x7f67040a84b0 of type 0 (in lttng_ht_new() at hashtable.c:145)</span></=
p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;boo=
k antiqua&quot;,serif">DEBUG3 - 03:25:07.923584 [20477/20482]: UST app chan=
nel metadata allocated (in alloc_ust_app_channel() at ust-app.c:1051)</span=
></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;=
book antiqua&quot;,serif">DEBUG2 - 03:25:07.923587 [20477/20482]: Asking US=
T consumer for channel (in ask_channel_creation() at ust-consumer.c:120)</s=
pan></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&qu=
ot;book antiqua&quot;,serif">DEBUG2 - 03:25:07.923704 [20477/20482]: UST as=
k channel 92 successfully done with 1 stream(s) (in ask_channel_creation() =
at ust-consumer.c:215)</span></p><p class=3D"MsoNormal"><span style=3D"font=
-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG2 - 03:25:07.923=
708 [20477/20482]: Consumer setup metadata channel key 92 (in consumer_setu=
p_metadata() at consumer.c:1273)</span></p><p class=3D"MsoNormal"><span sty=
le=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG2 - 03=
:25:07.924027 [20477/20482]: UST metadata with key 92 created for app pid 1=
9671 (in create_ust_app_metadata() at ust-app.c:3245)</span></p><p class=3D=
"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quo=
t;,serif">DEBUG3 - 03:25:07.924031 [20477/20482]: UST app deleting channel =
metadata (in delete_ust_app_channel() at ust-app.c:457)</span></p><p class=
=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&=
quot;,serif">DEBUG3 - 03:25:07.924033 [20477/20482]: Buffer registry per PI=
D find id: 19 (in buffer_reg_pid_find() at buffer-registry.c:317)</span></p=
><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book=
 antiqua&quot;,serif">DEBUG3 - 03:25:07.924036 [20477/20482]: UST registry =
channel finding key 92 (in ust_registry_channel_find() at ust-registry.c:78=
4)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-famil=
y:&quot;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNormal"><=
span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<b>######### CONSU=
MERD : adding metadata channel ####################</b></span></p><p class=
=3D"MsoNormal"><b><span style=3D"font-size:8pt;font-family:&quot;book antiq=
ua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ##########=C2=A0=C2=A0 378 is the FD for =
this channel=C2=A0=C2=A0 ####################</span></b></p><p class=3D"Mso=
Normal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,s=
erif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.923604 [2=
0706/20713]: Incoming command on sock (in consumer_thread_sessiond_poll(<wb=
r>) at consumer.c:3182)</span></p><p class=3D"MsoNormal"><span style=3D"fon=
t-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.923623 [20706/20713]: Allocated c=
hannel (key 92) (in consumer_allocate_channel() at consumer.c:1024)</span><=
/p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;bo=
ok antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - =
03:25:07.923626 [20706/20713]: Creating channel to ustctl with attr: [overw=
rite: 0, subbuf_size: 4096, num_subbuf: 2, switch_timer_interval: 0, read_t=
imer_interval: 0, output: 0, type: 1 (in create_ust_channel() at ust-consum=
er.c:458)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;fon=
t-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wb=
r>=C2=A0 DEBUG3 - 03:25:07.923683 [20706/20713]: Allocated stream metadata =
(key 378, chan_key 92 relayd_id 2, session_id 0 (in consumer_allocate_strea=
m() at consumer.c:608)</span></p><p class=3D"MsoNormal"><span style=3D"font=
-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.923687 [20706/20713]: UST consumer a=
dd stream metadata (key: 378) with relayd id 0 (in create_ust_streams() at =
ust-consumer.c:347)</span></p><p class=3D"MsoNormal"><span style=3D"font-si=
ze:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.923690 [20706/20713]: Allocated metadat=
a cache of 4096 bytes (in consumer_metadata_cache_<wbr>allocate() at consum=
er-metadata-cache.c:198)</span></p><p class=3D"MsoNormal"><span style=3D"fo=
nt-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.923694 [20706/20713]: UST consume=
r channel added (key: 92) (in add_channel() at ust-consumer.c:115)</span></=
p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;boo=
k antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - =
03:25:07.923697 [20706/20713]: received command on sock (in consumer_thread=
_sessiond_poll(<wbr>) at consumer.c:3198)</span></p><p class=3D"MsoNormal">=
<span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.923721 [20706/2=
0713]: Incoming command on sock (in consumer_thread_sessiond_poll(<wbr>) at=
 consumer.c:3182)</span></p><p class=3D"MsoNormal"><span style=3D"font-size=
:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.923731 [20706/20713]: UST consumer setu=
p metadata key 92 (in setup_metadata() at ust-consumer.c:876)</span></p><p =
class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book ant=
iqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:=
07.923734 [20706/20713]: Relayd adding stream for channel name metadata (in=
 relayd_add_stream() at relayd.c:252)</span></p><p class=3D"MsoNormal"><spa=
n style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:25:07.923759 [20706/20713]:=
 Relayd sending command 1 of size 4400 (in send_command() at relayd.c:81)</=
span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&q=
uot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEB=
UG3 - 03:25:07.923762 [20706/20713]: Relayd waiting for reply of size 12 (i=
n recv_reply() at relayd.c:101)</span></p><p class=3D"MsoNormal"><span styl=
e=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.923884 [20706/20713]: Relay=
d stream added successfully with handle 165 (in relayd_add_stream() at rela=
yd.c:317)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;fon=
t-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wb=
r>=C2=A0 DEBUG1 - 03:25:07.923888 [20706/20713]: Stream metadata with key 3=
78 sent to relayd id 2 (in consumer_send_relayd_stream() at consumer.c:811)=
</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:=
&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 =
DEBUG1 - 03:25:07.923890 [20706/20713]: Relayd sending streams sent. (in re=
layd_streams_sent() at relayd.c:336)</span></p><p class=3D"MsoNormal"><span=
 style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:25:07.923903 [20706/20713]:=
 Relayd sending command 16 of size 24 (in send_command() at relayd.c:81)</s=
pan></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&qu=
ot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEB=
UG3 - 03:25:07.923906 [20706/20713]: Relayd waiting for reply of size 4 (in=
 recv_reply() at relayd.c:101)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:25:07.923947 [20706/20713]: Relay=
d streams sent success (in relayd_streams_sent() at relayd.c:369)</span></p=
><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book=
 antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - =
03:25:07.923950 [20706/20713]: All streams sent relayd id 2 (in consumer_se=
nd_relayd_streams_<wbr>sent() at consumer.c:849)</span></p><p class=3D"MsoN=
ormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,se=
rif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:25:07.923952 [2=
0706/20713]: Adding metadata stream 378 to hash table (in consumer_add_meta=
data_stream() at consumer.c:2115)</span></p><p class=3D"MsoNormal"><span st=
yle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0</sp=
an></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quo=
t;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0<b>############## RELAYD : addi=
ng metadata channel handle id 165=C2=A0 #######################</b></span><=
/p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;bo=
ok antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG3 - 03:25:07.918301 [19663/1966=
6]: Relayd worker thread polling... (in relay_thread_worker() at main.c:248=
1)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-famil=
y:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG3 - 03:25:07.923820=
 [19663/19666]: Created hashtable size 4 at 0x7f1d4404ceb0 of type 2 (in lt=
tng_ht_new() at hashtable.c:145)</span></p><p class=3D"MsoNormal"><span sty=
le=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=
=C2=A0 DEBUG1 - 03:25:07.923855 [19663/19666]: Tracefile /var/log/lttng-tra=
ces/evo-<wbr>xb49-re0//DefaultSession-<wbr>20161207-032506//ust/pid/<wbr>tr=
ace_server-19671-20161207-<wbr>032507/metadata created (in stream_create() =
at stream.c:151)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:=
8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG1 - 03:=
25:07.923859 [19663/19666]: Relay new stream added metadata with ID 165 (in=
 stream_create() at stream.c:177)</span></p><p class=3D"MsoNormal"><span st=
yle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0</sp=
an></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quo=
t;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNormal"><span s=
tyle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0</span></p><p class=3D"MsoNormal"><span sty=
le=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0</span></p><p class=3D"MsoNormal"><b><span style=3D"font-size:8pt;fon=
t-family:&quot;book antiqua&quot;,serif">#######=C2=A0=C2=A0 SESSIOND : clo=
sing for trace_server=C2=A0=C2=A0 #######</span></b></p><p class=3D"MsoNorm=
al"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif=
">DEBUG1 - 03:39:11.176955 [20477/20482]: Flushing session buffers for all =
ust apps (in ust_app_flush_session() at ust-app.c:4583)</span></p><p class=
=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&=
quot;,serif">.....</span></p><p class=3D"MsoNormal"><b><span style=3D"font-=
size:8pt;font-family:&quot;book antiqua&quot;,serif">###### app going down =
at this point is picked up by sessiond=C2=A0=C2=A0 ######</span></b></p><p =
class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book ant=
iqua&quot;,serif">DEBUG1 - 03:55:51.236181 [20477/20485]: PID 19671 unregis=
tering with sock 81 (in ust_app_unregister() at ust-app.c:3437)</span></p><=
p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book a=
ntiqua&quot;,serif">DEBUG1 - 03:55:51.236190 [20477/20485]: Flushing app se=
ssion buffers for ust app pid 19671 (in ust_app_flush_app_session() at ust-=
app.c:4522)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;f=
ont-family:&quot;book antiqua&quot;,serif">DEBUG2 - 03:55:51.236196 [20477/=
20485]: Consumer flush channel key 383 (in consumer_flush_channel() at cons=
umer.c:1174)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;=
font-family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:55:51.236791 [20477=
/20485]: Buffer registry per PID find id: 201 (in buffer_reg_pid_find() at =
buffer-registry.c:317)</span></p><p class=3D"MsoNormal"><span style=3D"font=
-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG3 - 03:55:51.236=
798 [20477/20485]: No metadata to push for metadata key 456 (in ust_app_pus=
h_metadata() at ust-app.c:587)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DEBUG2 - 03:5=
5:51.236802 [20477/20485]: Consumer close metadata channel key 456 (in cons=
umer_close_metadata() at consumer.c:1240)</span></p><p class=3D"MsoNormal">=
<span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">DE=
BUG1 - 03:55:51.237113 [20477/20485]: Flushing app session buffers for ust =
app pid 19671 (in ust_app_flush_app_session() at ust-app.c:4522)</span></p>=
<p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book =
antiqua&quot;,serif">DEBUG2 - 03:55:51.237120 [20477/20485]: Consumer flush=
 channel key 19 (in consumer_flush_channel() at consumer.c:1174)</span></p>=
<p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book =
antiqua&quot;,serif">DEBUG3 - 03:55:51.237386 [20477/20485]: Buffer registr=
y per PID find id: 19 (in buffer_reg_pid_find() at buffer-registry.c:317)</=
span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&q=
uot;book antiqua&quot;,serif">DEBUG3 - 03:55:51.237391 [20477/20485]: No me=
tadata to push for metadata key 92 (in ust_app_push_metadata() at ust-app.c=
:587)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fa=
mily:&quot;book antiqua&quot;,serif">DEBUG2 - 03:55:51.237393 [20477/20485]=
: Consumer close metadata channel key 92 (in consumer_close_metadata() at c=
onsumer.c:1240)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8=
pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D=
"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quo=
t;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0<b>###### CONSUM=
ERD : getting request to close=C2=A0 ###########</b></span></p><p class=3D"=
MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot=
;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.237169=
 [20706/20713]: Incoming command on sock (in consumer_thread_sessiond_poll(=
<wbr>) at consumer.c:3182)</span></p><p class=3D"MsoNormal"><span style=3D"=
font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.237179 [20706/20713]: UST cons=
umer flush channel key 19 (in flush_channel() at ust-consumer.c:751)</span>=
</p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;b=
ook antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1=
 - 03:55:51.237362 [20706/20713]: received command on sock (in consumer_thr=
ead_sessiond_poll(<wbr>) at consumer.c:3198)</span></p><p class=3D"MsoNorma=
l"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif"=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.237411 [2070=
6/20713]: Incoming command on sock (in consumer_thread_sessiond_poll(<wbr>)=
 at consumer.c:3182)</span></p><p class=3D"MsoNormal"><span style=3D"font-s=
ize:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.237420 [20706/20713]: UST consumer c=
lose metadata key 92 (in close_metadata() at ust-consumer.c:835)</span></p>=
<p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book =
antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:=
55:51.277601 [20706/20713]: Closing metadata channel key 92 (in lttng_ustco=
nsumer_close_<wbr>metadata() at ust-consumer.c:2720)</span></p><p class=3D"=
MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot=
;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.277619=
 [20706/20713]: received command on sock (in consumer_thread_sessiond_poll(=
<wbr>) at consumer.c:3198)</span></p><p class=3D"MsoNormal"><span style=3D"=
font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>=C2=A0</span></p><p class=3D"MsoNormal"><span style=3D"=
font-size:8pt;font-family:&quot;book antiqua&quot;,serif"><b>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 ##### CONSUMERD : thread 20713 handling close=
_metadata is done here , but 20711 got an event for fd 378 associated with =
key 92 #####</b></span></p><p class=3D"MsoNormal"><span style=3D"font-size:=
8pt;font-family:&quot;book antiqua&quot;,serif"><b>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>=C2=A0 ##### consumerd is also polling on 104 and 106, they have=
 not hup|err here, there is a crucial delay =C2=A0######</b></span></p><p c=
lass=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book anti=
qua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:=
51.277662 [20706/20711]: Metadata poll return from wait with 78 fd(s) (in c=
onsumer_thread_metadata_poll(<wbr>) at consumer.c:2274)</span></p><p class=
=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&=
quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.=
277664 [20706/20711]: Metadata event caught in thread (in consumer_thread_m=
etadata_poll(<wbr>) at consumer.c:2276)</span></p><p class=3D"MsoNormal"><s=
pan style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.277668 [20706/2071=
1]: Metadata fd 378 is hup|err. (in consumer_thread_metadata_poll(<wbr>) at=
 consumer.c:2390)</span></p><p class=3D"MsoNormal"><span style=3D"font-size=
:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.277684 [20706/20711]: Attempting to flu=
sh and consume the UST buffers (in consumer_thread_metadata_poll(<wbr>) at =
consumer.c:2394)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:=
8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.277701 [20706/20711]: In UST read_subbuffe=
r (wait_fd: 378, name: metadata) (in lttng_ustconsumer_read_<wbr>subbuffer(=
) at ust-consumer.c:2439)</span></p><p class=3D"MsoNormal"><span style=3D"f=
ont-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.279107 [20706/20711]: Relayd send=
ing metadata of size 49 (in relayd_send_metadata() at relayd.c:459)</span><=
/p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;bo=
ok antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 .....</sp=
an></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quo=
t;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEB=
UG3 - 03:55:51.279123 [20706/20711]: Relayd sending command 6 of size 24 (i=
n send_command() at relayd.c:81)</span></p><p class=3D"MsoNormal"><span sty=
le=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG2 - 03:55:51.279126 [20706/20711]: Re=
layd metadata added successfully (in relayd_send_metadata() at relayd.c:467=
)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family=
:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 =
DEBUG1 - 03:55:51.279130 [20706/20711]: Metadata stream id 165 with padding=
 4059 written before data (in write_relayd_metadata_id() at consumer.c:1483=
)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family=
:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 =
DEBUG1 - 03:55:51.279134 [20706/20711]: Consumer mmap write() ret 37 (len 3=
7) (in lttng_consumer_on_read_<wbr>subbuffer_mmap() at consumer.c:1661)</sp=
an></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quo=
t;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEB=
UG1 - 03:55:51.279140 [20706/20711]: In UST read_subbuffer (wait_fd: 378, n=
ame: metadata) (in lttng_ustconsumer_read_<wbr>subbuffer() at ust-consumer.=
c:2439)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-=
family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=
=C2=A0 DEBUG3 - 03:55:51.279146 [20706/20711]: Consumer delete metadata str=
eam 378 (in consumer_del_metadata_stream() at consumer.c:2062)</span></p><p=
 class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book an=
tiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:=
55:51.279157 [20706/20711]: Closing metadata channel key 92 (in lttng_ustco=
nsumer_close_<wbr>metadata() at ust-consumer.c:2720)</span></p><p class=3D"=
MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot=
;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.279166=
 [20706/20711]: Relayd closing stream id 165 (in relayd_send_close_stream()=
 at relayd.c:594)</span></p><p class=3D"MsoNormal"><span style=3D"font-size=
:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>=C2=A0 DEBUG3 - 03:55:51.279170 [20706/20711]: Relayd sending co=
mmand 7 of size 40 (in send_command() at relayd.c:81)</span></p><p class=3D=
"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quo=
t;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:55:51.279=
172 [20706/20711]: Relayd waiting for reply of size 4 (in recv_reply() at r=
elayd.c:101)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;=
font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0 DEBUG3 - 03:55:51.289333 [20477/20490]: Call RCU deleting app P=
ID 19671 (in delete_ust_app_rcu() at ust-app.c:947)</span></p><p class=3D"M=
soNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;=
,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:55:51.289540=
 [20477/20490]: Buffer registry per PID find id: 19 (in buffer_reg_pid_find=
() at buffer-registry.c:317)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:55:51.289551 [20477/20490]: UST a=
pp deleting channel DefaultChannel (in delete_ust_app_channel() at ust-app.=
c:457)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-f=
amily:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=
=C2=A0 DEBUG3 - 03:55:51.289568 [20477/20490]: Buffer registry per PID find=
 id: 19 (in buffer_reg_pid_find() at buffer-registry.c:317)</span></p><p cl=
ass=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiq=
ua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:55:=
51.289571 [20477/20490]: UST registry channel finding key 19 (in ust_regist=
ry_channel_find() at ust-registry.c:784)</span></p><p class=3D"MsoNormal"><=
span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3 - 03:55:51.289613 [20477/2049=
0]: Session 0 found by id. (in session_find_by_id() at session.c:312)</span=
></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;=
book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG3=
 - 03:55:51.289616 [20477/20490]: Consumer discarded events id 0 (in consum=
er_get_discarded_events(<wbr>) at consumer.c:1428)</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,=
serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 .....</span></p><p class=
=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&=
quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.=
289658 [20706/20713]: Incoming command on sock (in consumer_thread_sessiond=
_poll(<wbr>) at consumer.c:3182)</span></p><p class=3D"MsoNormal"><span sty=
le=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.289700 [20706/20713]: US=
T consumer discarded events command for session id 0 (in lttng_ustconsumer_=
recv_cmd() at ust-consumer.c:1769)</span></p><p class=3D"MsoNormal"><span s=
tyle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.323528 [20706/20711]: Re=
layd close stream id 165 successfully (in relayd_send_close_stream() at rel=
ayd.c:623)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;fo=
nt-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wb=
r>=C2=A0 DEBUG1 - 03:55:51.323587 [20706/20711]: Consumer delete channel ke=
y 92 (in consumer_del_channel() at consumer.c:359)</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,=
serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,=
serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0</span></p><p class=3D"MsoNormal"><b><span style=3D=
"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 =
##### RELAYD : GOT SIGTERM and is going down, cleaning streams here #######=
</span></b></p><p class=3D"MsoNormal"><b><span style=3D"font-size:8pt;font-=
family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 ##### RELAYD : trying=
 to close streams 37 and 38. 37 got closed, 38 has data pending !! ########=
#############</span></b></p><p class=3D"MsoNormal"><span style=3D"font-size=
:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG1 - =
03:55:51.653672 [19663/19666]: Trying to close stream 37 (in try_stream_clo=
se() at stream.c:360)</span></p><p class=3D"MsoNormal"><span style=3D"font-=
size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG1=
 - 03:55:51.653675 [19663/19666]: stream_unpublish:: lttng_ht_del() : strea=
m 0x7f1d440125b0 refcount 1 stream 37 trace 19 session 1 (in stream_unpubli=
sh() at stream.c:252)</span></p><p class=3D"MsoNormal"><span style=3D"font-=
size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 DEBUG1=
 - 03:55:51.653677 [19663/19666]: Succeeded in closing stream 37 (in try_st=
ream_close() at stream.c:431)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=
=A0 DEBUG1 - 03:55:51.653678 [19663/19666]: stream put for stream id 37 (in=
 stream_put() at stream.c:335)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=
=A0 DEBUG1 - 03:55:51.653680 [19663/19666]: stream put stream id 37 refcoun=
t 1 (in stream_put() at stream.c:352)</span></p><p class=3D"MsoNormal"><spa=
n style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=
=A0=C2=A0 DEBUG1 - 03:55:51.653681 [19663/19666]: Releasing stream id 37 (i=
n stream_release() at stream.c:305)</span></p><p class=3D"MsoNormal"><span =
style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=
=A0=C2=A0 DEBUG1 - 03:55:51.653687 [19663/19666]: Trying to close stream 38=
 (in try_stream_close() at stream.c:360)</span></p><p class=3D"MsoNormal"><=
span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=
=C2=A0=C2=A0 DEBUG1 - 03:55:51.653690 [19663/19666]: closing stream 38 abor=
ted since it still has data pending (in try_stream_close() at stream.c:420)=
</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:=
&quot;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNormal"><sp=
an style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0</span></p><p class=3D"MsoNormal"><sp=
an style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0</span></p><p class=3D"MsoNormal"><b><span style=3D"font-size:8pt;font-f=
amily:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=
=C2=A0 ####### CONSUMERD : errors on fd 104 and 106 detected. Relayd has co=
mpletely exited at this point. ###########</span></b></p><p class=3D"MsoNor=
mal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,seri=
f">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.850362 [2070=
6/20712]: fd 104 is hup|err|nval. Attempting flush and read. (in consumer_t=
hread_data_poll() at consumer.c:2661)</span></p><p class=3D"MsoNormal"><spa=
n style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.850371 [20706/20712]:=
 Polling fd 104 tells it has hung up. (in consumer_thread_data_poll() at co=
nsumer.c:2672)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8p=
t;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.850375 [20706/20712]: fd 106 is hup|err|nv=
al. Attempting flush and read. (in consumer_thread_data_poll() at consumer.=
c:2661)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-=
family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=
=C2=A0 DEBUG1 - 03:55:51.850377 [20706/20712]: Polling fd 106 tells it has =
hung up. (in consumer_thread_data_poll() at consumer.c:2672)</span></p><p c=
lass=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book anti=
qua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNormal"><b><span style=3D"=
font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>=C2=A0 ###### RELAYD has waited for the &quot;data_pend=
ing&quot; to get completed for the stream 106 and gone down, now consumerd =
realizes that the app is going down =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ######</span></b></p><p class=3D"MsoNormal"><b><span style=3D"font-size=
:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0</span></b></p><p class=3D"MsoNormal"><span style=3D"fon=
t-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.859249 [20706/20712]: Normal read=
 on fd 104 (in consumer_thread_data_poll() at consumer.c:2636)</span></p><p=
 class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book an=
tiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:=
55:51.859253 [20706/20712]: In UST read_subbuffer (wait_fd: 104, name: Defa=
ultChannel_0) (in lttng_ustconsumer_read_<wbr>subbuffer() at ust-consumer.c=
:2439)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-f=
amily:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=
=C2=A0 DEBUG1 - 03:55:51.859256 [20706/20712]: Reserving sub buffer failed =
(everything is normal, it is due to concurrency) [ret: -11] (in lttng_ustco=
nsumer_read_<wbr>subbuffer() at ust-consumer.c:2490)</span></p><p class=3D"=
MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot=
;,serif">=C2=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8=
pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.859478 [20706/20712]: Delete flag set to d=
ata stream 106 (in update_endpoint_status_by_<wbr>netidx() at consumer.c:44=
6)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-famil=
y:&quot;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNormal"><=
span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.859546 [20706/2071=
2]: Normal read on fd 106 (in consumer_thread_data_poll() at consumer.c:263=
6)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-famil=
y:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0 DEBUG1 - 03:55:51.859548 [20706/20712]: In UST read_subbuffer (wait_fd:=
 106, name: DefaultChannel_1) (in lttng_ustconsumer_read_<wbr>subbuffer() a=
t ust-consumer.c:2439)</span></p><p class=3D"MsoNormal"><span style=3D"font=
-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.859550 [20706/20712]: Reserving sub =
buffer failed (everything is normal, it is due to concurrency) [ret: -11] (=
in lttng_ustconsumer_read_<wbr>subbuffer() at ust-consumer.c:2490)</span></=
p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;boo=
k antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0</span>=
</p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;b=
ook antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1=
 - 03:55:51.859577 [20706/20712]: Polling fd 104 tells it has hung up. (in =
consumer_thread_data_poll() at consumer.c:2672)</span></p><p class=3D"MsoNo=
rmal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,ser=
if">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.859582 [2=
0706/20712]: Consumer stream destroy monitored key: 104 (in destroy_close_s=
tream() at consumer-stream.c:268)</span></p><p class=3D"MsoNormal"><span st=
yle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:51.859592 [20706/20712]: Po=
lling fd 106 tells it has hung up. (in consumer_thread_data_poll() at consu=
mer.c:2672)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;f=
ont-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0 DEBUG1 - 03:55:51.859596 [20706/20712]: Consumer stream destroy=
 monitored key: 106 (in destroy_close_stream() at consumer-stream.c:268)</s=
pan></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&qu=
ot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEB=
UG1 - 03:55:51.859602 [20706/20712]: Consumer delete channel key 19 (in con=
sumer_del_channel() at consumer.c:359)</span></p><p class=3D"MsoNormal"><sp=
an style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=
=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-fami=
ly:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=
=A0 DEBUG1 - 03:55:51.868988 [20706/20711]: Closing metadata channel key 10=
4 (in lttng_ustconsumer_close_<wbr>metadata() at ust-consumer.c:2720)</span=
></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;=
book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1=
 - 03:55:51.869001 [20706/20711]: Consumer delete channel key 104 (in consu=
mer_del_channel() at consumer.c:359)</span></p><p class=3D"MsoNormal"><span=
 style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0<=
/span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&=
quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 =
DEBUG1 - 03:55:51.869347 [20706/20711]: Closing metadata channel key 106 (i=
n lttng_ustconsumer_close_<wbr>metadata() at ust-consumer.c:2720)</span></p=
><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book=
 antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - =
03:55:51.869359 [20706/20711]: Consumer delete channel key 106 (in consumer=
_del_channel() at consumer.c:359)</span></p><p class=3D"MsoNormal"><span st=
yle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0</sp=
an></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quo=
t;book antiqua&quot;,serif">=C2=A0</span></p><p class=3D"MsoNormal"><span s=
tyle=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:52.179253 [20706/20713]: In=
coming command on sock (in consumer_thread_sessiond_poll(<wbr>) at consumer=
.c:3182)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font=
-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wb=
r>=C2=A0 DEBUG1 - 03:55:52.179487 [20706/20713]: UST consumer close metadat=
a key 104 (in close_metadata() at ust-consumer.c:835)</span></p><p class=3D=
"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quo=
t;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:52.179=
517 [20706/20713]: UST consumer close metadata 104 not found (in close_meta=
data() at ust-consumer.c:845)</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">=C2=A0</span>=
</p><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;b=
ook antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1=
 - 03:55:52.229354 [20706/20713]: Incoming command on sock (in consumer_thr=
ead_sessiond_poll(<wbr>) at consumer.c:3182)</span></p><p class=3D"MsoNorma=
l"><span style=3D"font-size:8pt;font-family:&quot;book antiqua&quot;,serif"=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 DEBUG1 - 03:55:52.229443 [2070=
6/20713]: UST consumer close metadata key 106 (in close_metadata() at ust-c=
onsumer.c:835)</span></p><p class=3D"MsoNormal"><span style=3D"font-size:8p=
t;font-family:&quot;book antiqua&quot;,serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<wbr>=C2=A0 DEBUG1 - 03:55:52.229469 [20706/20713]: UST consumer close m=
etadata 106 not found (in close_metadata() at ust-consumer.c:845)</span></p=
><p class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book=
 antiqua&quot;,serif"><br></span></p><p class=3D"MsoNormal"><span style=3D"=
font-size:8pt;font-family:&quot;book antiqua&quot;,serif"><br></span></p><p=
 class=3D"MsoNormal"><span style=3D"font-size:8pt;font-family:&quot;book an=
tiqua&quot;,serif">Regards,</span></p><p class=3D"MsoNormal"><span style=3D=
"font-size:8pt;font-family:&quot;book antiqua&quot;,serif">Aravind.</span><=
/p></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Wed, Nov 30, 2016 at 1:10 AM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr=
">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">j=
eremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><span class=3D"">On 29 November 2016 at 14:19, Aravind HT &lt;<a=
 href=3D"mailto:aravind.ht@gmail.com">aravind.ht@gmail.com</a>&gt; wrote:<b=
r>
&gt; Hi,<br>
&gt;<br>
&gt;<br>
&gt; I was in the processes of upgrading to 2.8.1 and see the below relayd =
core.<br>
&gt; I am trying to get the logs for this but is proving hard to reproduce =
this<br>
&gt; scenario with full logs enabled and also as this is happening in a com=
plex<br>
&gt; environment, not sure why relayd is exiting.<br>
&gt;<br>
&gt; For the meantime, from <a href=3D"https://lwn.net/Articles/573432/" re=
l=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/<wbr>573432/</a=
>=C2=A0 , I see that<br>
&gt; cds_lfht_destroy() may fail in case the ht is not empty. Should the as=
sert()<br>
&gt; be there in relayd_cleanup() or do you know what can cause/simulate th=
is<br>
&gt; crash ?<br>
<br>
</span>Hi Aravind,<br>
<br>
The assert() is there because, at that point, the streams should have<br>
been &quot;torn down&quot; cleanly before exiting. It is a check to ensure =
we<br>
don&#39;t leak the object and, more importantly, properly close the trace<b=
r>
on disk.<br>
<br>
I am not sure what can cause the stream to be &quot;dangling&quot; at this<=
br>
point. Are you killing the relay daemon or is it closing on its own<br>
(presumably after encountering an error)?.<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<div><div class=3D"h5"><br>
&gt; Ive tried killing relayd with SIGINT, SIGTERM when sesions are being a=
ctive<br>
&gt; and that doesnt reproduce this.<br>
&gt;<br>
&gt; 55=C2=A0 =C2=A0 =C2=A0 ../sysdeps/unix/sysv/linux/<wbr>raise.c: No suc=
h file or directory.<br>
&gt; [Current thread is 1 (Thread 0x7fd7e7c0e980 (LWP 29366))]<br>
&gt; (gdb) info threads<br>
&gt;=C2=A0 =C2=A0Id=C2=A0 =C2=A0Target Id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Frame<br>
&gt;=C2=A0 =C2=A02=C2=A0 =C2=A0 Thread 0x7fd7e1b1c700 (LWP 29375) 0x00007fd=
7e6701996 in _int_free<br>
&gt; (av=3D&lt;optimized out&gt;, p=3D&lt;optimized out&gt;, have_lock=3D0)=
 at malloc.c:4059<br>
&gt; * 1=C2=A0 =C2=A0 Thread 0x7fd7e7c0e980 (LWP 29366) 0x00007fd7e66bd367 =
in __GI_raise<br>
&gt; (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/<wbr>raise.c:55<br=
>
&gt; (gdb) bt full<br>
&gt; #0=C2=A0 0x00007fd7e66bd367 in __GI_raise (sig=3Dsig@entry=3D6) at<br>
&gt; ../sysdeps/unix/sysv/linux/<wbr>raise.c:55<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resultvar =3D 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pid =3D 29366<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selftid =3D 29366<br>
&gt; #1=C2=A0 0x00007fd7e66c033a in __GI_abort () at abort.c:89<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0save_stage =3D 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0act =3D {__sigaction_handler =3D {sa_=
handler =3D 0x4, sa_sigaction =3D 0x4},<br>
&gt; sa_mask =3D {__val =3D {5, 48, 140732823353744, 3924933264, 0, 0, 0,<b=
r>
&gt; 21474836480, 140732823353896, 140565261773123,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0140732823353696,=
 140565261807824, 140565261789000,<br>
&gt; 140732823354144, 140565282869248, 140565261789000}}, sa_flags =3D 4462=
201,<br>
&gt; sa_restorer =3D 0x4416c0 &lt;__PRETTY_FUNCTION__.5555&gt;}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigs =3D {__val =3D {32, 0 &lt;repeat=
s 15 times&gt;}}<br>
&gt; #2=C2=A0 0x00007fd7e66b644d in __assert_fail_base (fmt=3D0x7fd7e67f274=
8 &quot;%s%s%s:%u:<br>
&gt; %s%sAssertion `%s&#39; failed.\n%n&quot;, assertion=3Dassertion@entry=
=3D<wbr>0x441679 &quot;!ret&quot;,<br>
&gt; file=3Dfile@entry=3D0x4415da &quot;hashtable.c&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0line=3Dline@entry=3D162, function=3Dfunction@entry=
=3D<wbr>0x4416c0<br>
&gt; &lt;__PRETTY_FUNCTION__.5555&gt; &quot;lttng_ht_destroy&quot;) at asse=
rt.c:92<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0str =3D 0x65b310 &quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total =3D 4096<br>
&gt; #3=C2=A0 0x00007fd7e66b6502 in __GI___assert_fail (assertion=3D0x44167=
9 &quot;!ret&quot;,<br>
&gt; file=3D0x4415da &quot;hashtable.c&quot;, line=3D162, function=3D0x4416=
c0<br>
&gt; &lt;__PRETTY_FUNCTION__.5555&gt; &quot;lttng_ht_destroy&quot;) at asse=
rt.c:101<br>
&gt; No locals.<br>
&gt; #4=C2=A0 0x0000000000422f17 in lttng_ht_destroy (ht=3D0x65a0e0) at has=
htable.c:162<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__PRETTY_FUNCTION__ =3D &quot;lttng_h=
t_destroy&quot;<br>
&gt; #5=C2=A0 0x000000000040803b in relayd_cleanup () at main.c:497<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__ =3D &quot;relayd_cleanup&quo=
t;<br>
&gt; #6=C2=A0 0x000000000040ec4c in main (argc=3D5, argv=3D0x7ffee9f1bd68) =
at main.c:2939<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D 0x0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__ =3D &quot;main&quot;<br>
&gt;<br>
&gt; (gdb) f 4<br>
&gt; #4=C2=A0 0x0000000000422f17 in lttng_ht_destroy (ht=3D0x65a0e0) at has=
htable.c:162<br>
&gt; 162=C2=A0 =C2=A0 =C2=A0hashtable.c: No such file or directory.<br>
&gt; (gdb) p *ht-&gt;ht<br>
&gt; $1 =3D {max_nr_buckets =3D 9223372036854775808, mm =3D 0x7fd7e6e50920<=
br>
&gt; &lt;cds_lfht_mm_order&gt;,<br>
&gt; flavor =3D 0x7fd7e77b6340 &lt;rcu_flavor_memb&gt;, count =3D -1024, re=
size_mutex =3D<br>
&gt; {__data =3D {<br>
&gt; __lock =3D 0, __count =3D 0, __owner =3D 0, __nusers =3D 0, __kind =3D=
 0, __spins =3D 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__elision =3D 0, __list =3D {__prev =3D 0x0,=
 __next =3D 0x0}},<br>
&gt;=C2=A0 =C2=A0 =C2=A0__size =3D &#39;\000&#39; &lt;repeats 39 times&gt;,=
 __align =3D 0}, resize_attr =3D 0x0,<br>
&gt;=C2=A0 =C2=A0in_progress_resize =3D 0, in_progress_destroy =3D 1, resiz=
e_target =3D 2048,<br>
&gt;=C2=A0 =C2=A0resize_initiated =3D 0, flags =3D 3, min_alloc_buckets_ord=
er =3D 0,<br>
&gt; min_nr_alloc_buckets =3D 1,<br>
&gt;=C2=A0 =C2=A0split_count =3D 0x65b170, .., bucket_at =3D 0x7fd7e6c4e080=
 &lt;bucket_at&gt;, {<br>
&gt;=C2=A0 =C2=A0 =C2=A0tbl_order =3D {0x65b280, 0x65b2a0, 0x65b2c0, 0x7fd7=
c40008c0,<br>
&gt; 0x7fd7c4000910,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A00x7fd7c40009a0, 0x7fd7c4000ab0, 0x7fd7c40010=
70, 0x7fd7c4001480,<br>
&gt; 0x7fd7c4001c90,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A00x7fd7c4003350, 0x7fd7c4005360, 0x0 &lt;repe=
ats 52 times&gt;}, tbl_chunk =3D<br>
&gt; 0x65af60,<br>
&gt;=C2=A0 =C2=A0 =C2=A0tbl_mmap =3D 0x65b280}}<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt; Aravind.<br>
&gt;<br>
</div></div>&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</font></span></blockquote></div><br></div>

--001a114c9ccc64475b054372769a--

--===============7574366530603761154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7574366530603761154==--
