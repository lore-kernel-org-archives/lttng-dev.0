From: Anup Pemmaiah <anup.pemmaiah@gmail.com>
Subject: Re: Latency tracing using LTTng
Date: Thu, 4 Jan 2018 11:05:26 -0800
Message-ID: <CAF_EZTOoGrKD78iJQ9ZXAAirJWK+ZoLB1jeiPz1zUmjO5s9_UA__46170.5972244546$1515092634$gmane$org@mail.gmail.com>
References: <CAF_EZTMO2Npe+aR=OM9pmJ05hGQVZrkY2otDPK_=6+rjoNiZVQ@mail.gmail.com>
 <20171228024031.nh7lft2qmukozcuu@psrcode-TP-X230>
 <CAF_EZTOeG7pmyb2nwQ71TGCM35LoVfuP8a1bPZHWTUWmN+VhmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5858918309826942133=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x235.google.com (mail-io0-x235.google.com
 [IPv6:2607:f8b0:4001:c06::235])
 by lists.lttng.org (Postfix) with ESMTPS id 3zCHLc1TyLznJN
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jan 2018 19:05:27 +0000 (UTC)
Received: by mail-io0-x235.google.com with SMTP id z130so3251569ioe.13
 for <lttng-dev@lists.lttng.org>; Thu, 04 Jan 2018 11:05:27 -0800 (PST)
In-Reply-To: <CAF_EZTOeG7pmyb2nwQ71TGCM35LoVfuP8a1bPZHWTUWmN+VhmQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============5858918309826942133==
Content-Type: multipart/alternative; boundary="001a11453638ccd8bf0561f803be"

--001a11453638ccd8bf0561f803be
Content-Type: text/plain; charset="UTF-8"

Hi,

Was curious if any of the experts had any comments/suggestions on the issue
I am facing.

Thanks
Anup

On Wed, Dec 27, 2017 at 9:02 PM, Anup Pemmaiah <anup.pemmaiah@gmail.com>
wrote:

>
>
> On Wed, Dec 27, 2017 at 6:40 PM, Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
>
>> Hi,
>>
>> On Wed, Dec 27, 2017 at 05:21:30PM -0800, Anup Pemmaiah wrote:
>> > Hi,
>> >
>> > I am trying to find the reason of a intermittent latency that I am
>> noticing
>> > on my Linux system running on a RT_PREEMPT kernel. I have patched it on
>> a
>> > Ubuntu 16.04 LTS. Have stopped the desktop lightdm service and this is
>> on a
>>
>> Could we get more details on the version of the RT kernel?
>> Version/patchset?
>>
>
> The kernel and RT_PREEMPT patch is 4.4.38-rt49
>
>
>>
>> > Arm aarch64 platform.
>> >
>> > At a very high level, there are two processes interacting with each
>> other.
>> > Process-1 does some work and sends UDP messages to Process-2 (Using the
>> > FASTRTPS real time Publish-Subscribe protocol).
>>
>> Are you using the eProsima implementation? If so, could you give us more
>> information on the tracing strategy?
>>
>
>
>
> Yes. In my situation, it is part of the ROS(http://www.ros.org/) stack.
> So ROS middlewear uses eProsima underneath for publishing and subscribing.
> My process sits on top of ROS stack and
> uses it for message passing.
>
>
> Right now I have not addigned at RT priorities. All tasks are running with
> SCHED_OTHER with default prio 20.
>
> I load the modules as follows
>
> $modprobe latency_tracker
>
> $modprobe latency_tracker_syscalls
>
> $modprobe lttng-probe-latency_tracker
>
> $echo 100000 > /sys/kernel/debug/latency/syscalls/default/threshold
>
> Start LTTng
>
> $sudo lttng-sessiond --daemonize
>
> $echo 1 > /sys/kernel/debug/latency/syscalls/default/tracking_on
>
>
> Process-1 has a thread which keeps doing some work and publishing messages
> every 100ms. I start Process-1 as
>
> LD_PRELOAD=liblttng-profile.so <Process-1>
>
> It gives some relevant information about few stack traces.
>
> Timestamp Channel CPU Event type Contents Binary Location Function
> Location Source Location TID
> 16:13:32.971 988 199 u_5 5 lttng_profile:off_cpu_sample
> stack=/lib/aarch64-linux-gnu/libpthread.so.0(__nanosleep+0x28)
> [0x7f98233238]
> /home/nvidia/workspace/test_672/grand_central/apex_ws/instal
> l/lib/libvelodyne_driver.so(_ZNK8velodyne14input_socket_c11r
> ead_packetERNS_8packet_sE+0x160) [0x7f9826e418]
> /home/nvidia/workspace/test_672/grand_central/apex_ws/instal
> l/lib/libvelodyne_driver.so(_ZN8velodyne8driver_c16read_from_socketEv+0x30)
> [0x7f9826c390]
> /home/nvidia/workspace/test_672/grand_central/apex_ws/instal
> l/lib/libvelodyne_driver.so(_ZNK8velodyne8driver_c3runESt8fu,
> overhead=313869, context._vtid=11713 11713
>
> 16:13:32.973 972 119 u_0 0 lttng_profile:off_cpu_sample
> stack=/lib/aarch64-linux-gnu/libpthread.so.0(__nanosleep+0x28)
> [0x7f98233238]
> /home/nvidia/workspace/test_672/grand_central/apex_ws/instal
> l/lib/libvelodyne_driver.so(_ZNK8velodyne14input_socket_c11r
> ead_packetERNS_8packet_sE+0x160) [0x7f9826e418]
> /home/nvidia/workspace/test_672/grand_central/apex_ws/instal
> l/lib/libvelodyne_driver.so(_ZN8velodyne8driver_c16read_from_socketEv+0x30)
> [0x7f9826c390]
> /home/nvidia/workspace/test_672/grand_central/apex_ws/instal
> l/lib/libvelodyne_driver.so(_ZNK8velodyne8driver_c3runESt8fu,
> overhead=809697, context._vtid=11713 11713
>
> 16:13:32.973 981 912 u_4 4 lttng_profile:off_cpu_sample
> stack=/lib/aarch64-linux-gnu/libpthread.so.0(__nanosleep+0x28)
> [0x7f98233238]
> /home/nvidia/workspace/test_672/grand_central/apex_ws/instal
> l/lib/libvelodyne_driver.so(_ZNK8velodyne8driver_c3runESt8functionIFvvEE+0x94)
> [0x7f9826c4a4]
> /home/nvidia/workspace/test_672/grand_central/apex_ws/instal
> l/lib/libvelodyne_driver.so(_ZNSt6thread5_ImplISt12_Bind_simpleIFSt7_Mem_
> fnIMN8velodyne8driver_cEKFvSt8functionIFvvEEEEPS4_St5_
> BindIFS2_IMS4_FvvEESB_EEEEE6_M_runEv+0x8c) [0x7f9826d9fc]
> /usr/lib/aarch64-linux-gnu/libstdc++.so., overhead=469267,
> context._vtid=11715 11715
>
> 16:13:32.973 999 544 u_3 3 lttng_profile:off_cpu_sample
> stack=/lib/aarch64-linux-gnu/libpthread.so.0(sendmsg+0x2c) [0x7f9823303c]
> /opt/ros2/lib/libfastrtps.so.1(_ZN8eprosima8fastrtps4rtps14U
> DPv4Transport17SendThroughSocketEPKhjRKNS1_9Locator_tERN4asi
> o21basic_datagram_socketINS8_2ip3udpEEE+0xf8) [0x7f9647ad88]
> /opt/ros2/lib/libfastrtps.so.1(_ZN8eprosima8fastrtps4rtps14U
> DPv4Transport4SendEPKhjRKNS1_9Locator_tES7_+0x158) [0x7f9647c3e0]
> /opt/ros2/lib/libfastrtps.so.1(_ZN8eprosima8fastrtps4rtps14S
> enderResource4SendEPKhjRKNS1_9Locator_tE+0x4c) [0x7f9644b58c]
> /opt/ros2/lib/, overhead=1289108, context._vtid=11712 11712
>
> Once in a while when I kill the process with <ctrl-c> it hangs but not
> always.
>
> Process-2 has a thread which subscribes for the messages.
>
> When I start LD_PRELOAD=liblttng-profile.so <Process-2>, it just hangs
>
>
>
>>
>> > Data is sent from Process-1 to Process-2 every 100ms. I see that often
>> > there is a delay in Process-2 receiving the message.
>> >
>> >
>> > Trying to use LTTng and along with other supported profiling tools like
>> > latency-tracker, lttng-profile.
>> > Something like the description in this link
>> > http://lttng.org/blog/2015/03/18/full-stack-latencies is what I am
>> looking
>> > for, but I am facing issues. The latency_tracker kernel modules and also
>> > lttng-profile is a bit flaky as it sometimes work and sometimes panics
>> the
>> > kernel.  Simple test cases as provided in
>> > https://github.com/fdoray/latency_tracker_demo works sometimes. And
>> also
>>
>> Not sure if those aged properly.
>>
>> If you did not already, I would recommend you take a look at the
>> latency-tracker
>> github page [1] that this project references and uses. It changed quite a
>> lot
>> in the last 3 years.
>>
>> [1] https://github.com/efficios/latency-tracker
>
>
> Yes, that is where I downloaded the source and followed.
>
>>
>>
>>
>> > profiling Process-1 works by providing some useful traces(intermittently
>> > kernel panics), but profiling Process-2 the process just hangs.
>>
>> What version of lttng-modules are you using? The latency_tracker_demo
>> install
>> script seems to use lttng-modules 2.6. 2.6 is not supported anymore, it
>> would be
>> interesting to perform you experimentation with a newer version.
>>
>
> Sorry for not being clear in my earlier msg. I did not use the install
> scripts. All the kernel mdoules, LTTng modules, latency-tracker modules and
> user space libs
> lttng-ust, lttng-tools, lttng-profile was downloaded from git hub few
> weeks ago and build from source and loaded.
>
> From the latency_tracker_demo, I just built the sleep-demo and used the
> trace.sh to do the tracing
>
>
>>
>> Still, could you provide the panics call stack?
>>
>
> I do not see a panic trace all the time. In the previous run, when I tried
> to kill the Process-2 with "kill -9 <pid>", as it was hung, the system just
> rebooted without panic.
>
>
> This is from the syslog, and I see the same output on console
>
> 1613 Dec 27 16:53:37  kernel: [12566.627939] ring buffer relay-metadata: 0
> records written, 0 records overrun
> 1614 Dec 27 16:53:37  kernel: [12566.634983] ring buffer relay-metadata,
> cpu -1: non-consumed data
> 1615 Dec 27 16:53:37  kernel: [12566.634983]   [ 12288 bytes written, 8192
> bytes read ]
> 1616 Dec 27 16:53:37  kernel: [12566.646189] ring buffer: relay-metadata,
> cpu -1: 8192 bytes committed
> 1617 Dec 27 16:53:37  kernel: [12566.652780] ring buffer relay-discard,
> cpu 0: 0 records written, 0 records overrun
> 1618 Dec 27 16:53:38  kernel: [12566.660865] ring buffer relay-discard,
> cpu 1: 0 records written, 0 records overrun
> 1619 Dec 27 16:53:38  kernel: [12566.668924] ring buffer relay-discard,
> cpu 2: 0 records written, 0 records overrun
> 1620 Dec 27 16:53:38  kernel: [12566.676897] ring buffer relay-discard,
> cpu 3: 0 records written, 0 records overrun
> 1621 Dec 27 16:53:38  kernel: [12566.684809] ring buffer relay-discard,
> cpu 4: 0 records written, 0 records overrun
> 1622 Dec 27 16:53:38  kernel: [12566.692681] ring buffer relay-discard,
> cpu 5: 0 records written, 0 records overrun
> 1623 Dec 27 16:54:16  avahi-daemon[948]: Registering new address record
> for 10.31.33.48 on eth0.IPv4.
> 1624 Dec 27 16:54:16  rsyslogd-2007: action 'action 9' suspended, next
> retry is Wed Dec 27 16:55:46 2017 [v8.16.0 t     ry
> http://www.rsyslog.com/e/2007 ]
> 1625 Dec 27 16:54:16  systemd-timesyncd[816]: Network configuration
> changed, trying to establish connection.
> 1626 Dec 27 16:54:16  systemd-timesyncd[816]: Synchronized to time server
> 91.189.94.4:123 (ntp.ubuntu.com).
> 1627 Dec 27 16:54:17  rsyslogd: [origin software="rsyslogd"
> swVersion="8.16.0" x-pid="924" x-info="http://www.rsysl     og.com"]
> start
> 1628 Dec 27 16:54:17  rsyslogd-2222: command 'KLogPermitNonKernelFacility'
> is currently not permitted - did you alr     eady set it via a RainerScript
> command (v6+ config)? [v8.16.0 try http://www.rsyslog.com/e/2222 ]
> 1629 Dec 27 16:54:17  rsyslogd: rsyslogd's groupid changed to 115
> 1630 Dec 27 16:54:17  rsyslogd: rsyslogd's userid changed to 108
> 1631 Dec 27 16:54:17  kernel: [    0.000000] Booting Linux on physical CPU
> 0x100
> 1632 Dec 27 16:54:17  kernel: [    0.000000] Initializing cgroup subsys
> cpuset
> 1633 Dec 27 16:54:17  kernel: [    0.000000] Initializing cgroup subsys cpu
> 1634 Dec 27 16:54:17  kernel: [    0.000000] Initializing cgroup subsys
> cpuacct
> 1635 Dec 27 16:54:17  kernel: [    0.000000] Linux version
> 4.4.38-rt49-tegra (anup.pemmaiah@anup-pemmaiah) (gcc ver     sion 4.9.2
> (GCC) ) #1 SMP PREEMPT RT Thu Nov 30 17:12:21 PST 2017
> 1636 Dec 27 16:54:17  kernel: [    0.000000] Boot CPU: AArch64 Processor
> [411fd073]
> 1637 Dec 27 16:54:17  kernel: [    0.000000] earlycon: Early serial
> console at MMIO32
>
>
>>
>> >
>> > Not sure how updated the above pasted links are, because I notice there
>> is
>> > no more usec_threshold parameter and I use the threshold
>> > in /sys/kernel/debug/latency/syscalls/default/threshold
>> >
>> > I understand each situation is different, but was curious if  any of you
>> > have comments/suggestions that would help in debugging latency related
>> > issues using LTTng. I have looked many places to get required info but
>> of
>> > not much help.
>>
>> Most of the maintainers are on vacation during this part of the year so
>> it might
>> take some time to get answers. I'm sure that Julien Desfossez will be
>> interested in your use case.
>>
>> Cheers
>>
>
> I undersatnd and any suggestions will be very helpful
>
>>
>> >
>> > Your comments/suggestions will be greatly appreciated.
>> >
>> > Thanks
>> > Anup
>>
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Jonathan Rajotte-Julien
>> EfficiOS
>>
>
>

--001a11453638ccd8bf0561f803be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Was curious if any of the experts h=
ad any comments/suggestions on the issue I am facing.</div><div><br></div><=
div>Thanks</div><div>Anup</div><div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Wed, Dec 27, 2017 at 9:02 PM, Anup Pemmaiah <span dir=
=3D"ltr">&lt;<a href=3D"mailto:anup.pemmaiah@gmail.com" target=3D"_blank">a=
nup.pemmaiah@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote"><span>On Wed, Dec 27, 2017 at 6:40 PM, Jonathan Rajotte-Julien <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com" t=
arget=3D"_blank">jonathan.rajotte-julien@effic<wbr>ios.com</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"m_8854001346163611844m_-4183753690866262461gmail-"><br>
On Wed, Dec 27, 2017 at 05:21:30PM -0800, Anup Pemmaiah wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am trying to find the reason of a intermittent latency that I am not=
icing<br>
&gt; on my Linux system running on a RT_PREEMPT kernel. I have patched it o=
n a<br>
&gt; Ubuntu 16.04 LTS. Have stopped the desktop lightdm service and this is=
 on a<br>
<br>
</span>Could we get more details on the version of the RT kernel? Version/p=
atchset?<br></blockquote><div><br></div></span><div>The kernel and RT_PREEM=
PT patch is 4.4.38-rt49</div><span><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<span class=3D"m_8854001346163611844m_-4183753690866262461gmail-"><br>
&gt; Arm aarch64 platform.<br>
&gt;<br>
&gt; At a very high level, there are two processes interacting with each ot=
her.<br>
&gt; Process-1 does some work and sends UDP messages to Process-2 (Using th=
e<br>
&gt; FASTRTPS real time Publish-Subscribe protocol).<br>
<br>
</span>Are you using the eProsima implementation? If so, could you give us =
more<br>
information on the tracing strategy?<br></blockquote><div><br></div><div><b=
r></div><div>=C2=A0</div></span><div>Yes. In my situation, it is part of th=
e ROS(<a href=3D"http://www.ros.org/" target=3D"_blank">http://www.ros.org/=
</a>) stack. So ROS middlewear uses eProsima underneath for publishing and =
subscribing. My process sits on top of ROS stack and</div><div>uses it for =
message passing.</div><div><br></div><div><br></div><div>Right now I have n=
ot addigned at RT priorities. All tasks are running with SCHED_OTHER with d=
efault prio 20.<br></div><div><br></div><div>I load the modules as follows<=
/div><div><br></div><div>$modprobe latency_tracker</div><div><br></div><div=
>$modprobe latency_tracker_syscalls<br></div><div><br></div><div>$modprobe =
lttng-probe-latency_tracker</div><div><br></div><div>$echo 100000 &gt; /sys=
/kernel/debug/latency/sysc<wbr>alls/default/threshold</div><div><br></div><=
div>Start LTTng</div><div><br></div><div>$sudo lttng-sessiond --daemonize</=
div><div><br></div><div>$echo 1 &gt; /sys/kernel/debug/latency/sysc<wbr>all=
s/default/tracking_on</div><div><br></div><div><br></div><div>Process-1 has=
 a thread which keeps doing some work and publishing messages every 100ms. =
I start Process-1 as</div><div><br></div><div>LD_PRELOAD=3Dliblttng-profile=
.so &lt;Process-1&gt;<br></div><div><br></div><div>It gives some relevant i=
nformation about few stack traces.=C2=A0</div><div><div><br></div><div>Time=
stamp<span style=3D"white-space:pre-wrap">	</span>Channel<span style=3D"whi=
te-space:pre-wrap">	</span>CPU<span style=3D"white-space:pre-wrap">	</span>=
Event type<span style=3D"white-space:pre-wrap">	</span>Contents<span style=
=3D"white-space:pre-wrap">	</span>Binary Location<span style=3D"white-space=
:pre-wrap">	</span>Function Location<span style=3D"white-space:pre-wrap">	<=
/span>Source Location<span style=3D"white-space:pre-wrap">	</span>TID</div>=
<div>16:13:32.971 988 199<span style=3D"white-space:pre-wrap">	</span>u_5<s=
pan style=3D"white-space:pre-wrap">	</span>5<span style=3D"white-space:pre-=
wrap">	</span>lttng_profile:off_cpu_sample<span style=3D"white-space:pre-wr=
ap">	</span>stack=3D/lib/aarch64-linux-gnu/l<wbr>ibpthread.so.0(__nanosleep=
+0x2<wbr>8) [0x7f98233238]</div><div>/home/nvidia/workspace/test_67<wbr>2/g=
rand_central/apex_ws/instal<wbr>l/lib/libvelodyne_driver.so(_Z<wbr>NK8velod=
yne14input_socket_c11r<wbr>ead_packetERNS_8packet_sE+0x16<wbr>0) [0x7f9826e=
418]</div><div>/home/nvidia/workspace/test_67<wbr>2/grand_central/apex_ws/i=
nstal<wbr>l/lib/libvelodyne_driver.so(_<wbr>ZN8velodyne8driver_c16read_<wbr=
>from_socketEv+0x30) [0x7f9826c390]</div><div>/home/nvidia/workspace/test_6=
7<wbr>2/grand_central/apex_ws/instal<wbr>l/lib/libvelodyne_driver.so(_Z<wbr=
>NK8velodyne8driver_c3runESt8fu<wbr>, overhead=3D313869, context._vtid=3D11=
713<span style=3D"white-space:pre-wrap">				</span>11713</div><div><br></di=
v><div>16:13:32.973 972 119<span style=3D"white-space:pre-wrap">	</span>u_0=
<span style=3D"white-space:pre-wrap">	</span>0<span style=3D"white-space:pr=
e-wrap">	</span>lttng_profile:off_cpu_sample<span style=3D"white-space:pre-=
wrap">	</span>stack=3D/lib/aarch64-linux-gnu/l<wbr>ibpthread.so.0(__nanosle=
ep+0x2<wbr>8) [0x7f98233238]</div><div>/home/nvidia/workspace/test_67<wbr>2=
/grand_central/apex_ws/instal<wbr>l/lib/libvelodyne_driver.so(_Z<wbr>NK8vel=
odyne14input_socket_c11r<wbr>ead_packetERNS_8packet_sE+0x16<wbr>0) [0x7f982=
6e418]</div><div>/home/nvidia/workspace/test_67<wbr>2/grand_central/apex_ws=
/instal<wbr>l/lib/libvelodyne_driver.so(_<wbr>ZN8velodyne8driver_c16read_<w=
br>from_socketEv+0x30) [0x7f9826c390]</div><div>/home/nvidia/workspace/test=
_67<wbr>2/grand_central/apex_ws/instal<wbr>l/lib/libvelodyne_driver.so(_Z<w=
br>NK8velodyne8driver_c3runESt8fu<wbr>, overhead=3D809697, context._vtid=3D=
11713<span style=3D"white-space:pre-wrap">				</span>11713</div><div><br></=
div><div>16:13:32.973 981 912<span style=3D"white-space:pre-wrap">	</span>u=
_4<span style=3D"white-space:pre-wrap">	</span>4<span style=3D"white-space:=
pre-wrap">	</span>lttng_profile:off_cpu_sample<span style=3D"white-space:pr=
e-wrap">	</span>stack=3D/lib/aarch64-linux-gnu/l<wbr>ibpthread.so.0(__nanos=
leep+0x2<wbr>8) [0x7f98233238]</div><div>/home/nvidia/workspace/test_67<wbr=
>2/grand_central/apex_ws/instal<wbr>l/lib/libvelodyne_driver.so(_Z<wbr>NK8v=
elodyne8driver_c3runESt8fu<wbr>nctionIFvvEE+0x94) [0x7f9826c4a4]</div><div>=
/home/nvidia/workspace/test_67<wbr>2/grand_central/apex_ws/instal<wbr>l/lib=
/libvelodyne_driver.so(_<wbr>ZNSt6thread5_ImplISt12_Bind_<wbr>simpleIFSt7_M=
em_<wbr>fnIMN8velodyne8driver_cEKFvSt8<wbr>functionIFvvEEEEPS4_St5_<wbr>Bin=
dIFS2_IMS4_FvvEESB_EEEEE6_<wbr>M_runEv+0x8c) [0x7f9826d9fc]</div><div>/usr/=
lib/aarch64-linux-gnu/lib<wbr>stdc++.so., overhead=3D469267, context._vtid=
=3D11715<span style=3D"white-space:pre-wrap">				</span>11715</div><div><br=
></div><div>16:13:32.973 999 544<span style=3D"white-space:pre-wrap">	</spa=
n>u_3<span style=3D"white-space:pre-wrap">	</span>3<span style=3D"white-spa=
ce:pre-wrap">	</span>lttng_profile:off_cpu_sample<span style=3D"white-space=
:pre-wrap">	</span>stack=3D/lib/aarch64-linux-gnu/l<wbr>ibpthread.so.0(send=
msg+0x2c) [0x7f9823303c]</div><div>/opt/ros2/lib/libfastrtps.so.1<wbr>(_ZN8=
eprosima8fastrtps4rtps14U<wbr>DPv4Transport17SendThroughSock<wbr>etEPKhjRKN=
S1_9Locator_tERN4asi<wbr>o21basic_datagram_socketINS8_<wbr>2ip3udpEEE+0xf8)=
 [0x7f9647ad88]</div><div>/opt/ros2/lib/libfastrtps.so.1<wbr>(_ZN8eprosima8=
fastrtps4rtps14U<wbr>DPv4Transport4SendEPKhjRKNS1_9<wbr>Locator_tES7_+0x158=
) [0x7f9647c3e0]</div><div>/opt/ros2/lib/libfastrtps.so.1<wbr>(_ZN8eprosima=
8fastrtps4rtps14S<wbr>enderResource4SendEPKhjRKNS1_9<wbr>Locator_tE+0x4c) [=
0x7f9644b58c]</div><div>/opt/ros2/lib/, overhead=3D1289108, context._vtid=
=3D11712<span style=3D"white-space:pre-wrap">				</span>11712</div></div><d=
iv><br></div><div>Once in a while when I kill the process with &lt;ctrl-c&g=
t; it hangs but not always.</div><div><br></div><div>Process-2 has a thread=
 which subscribes for the messages.</div><div><br></div><div>When I start L=
D_PRELOAD=3Dliblttng-profile.so &lt;Process-2&gt;, it just hangs<br></div><=
span><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<span class=3D"m_8854001346163611844m_-4183753690866262461gmail-"><br>
&gt; Data is sent from Process-1 to Process-2 every 100ms. I see that often=
<br>
&gt; there is a delay in Process-2 receiving the message.<br>
&gt;<br>
&gt;<br>
&gt; Trying to use LTTng and along with other supported profiling tools lik=
e<br>
&gt; latency-tracker, lttng-profile.<br>
&gt; Something like the description in this link<br>
&gt; <a href=3D"http://lttng.org/blog/2015/03/18/full-stack-latencies" rel=
=3D"noreferrer" target=3D"_blank">http://lttng.org/blog/2015/03/<wbr>18/ful=
l-stack-latencies</a> is what I am looking<br>
&gt; for, but I am facing issues. The latency_tracker kernel modules and al=
so<br>
&gt; lttng-profile is a bit flaky as it sometimes work and sometimes panics=
 the<br>
&gt; kernel.=C2=A0 Simple test cases as provided in<br>
&gt; <a href=3D"https://github.com/fdoray/latency_tracker_demo" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/fdoray/late<wbr>ncy_tracker_de=
mo</a> works sometimes. And also<br>
<br>
</span>Not sure if those aged properly.<br>
<br>
If you did not already, I would recommend you take a look at the latency-tr=
acker<br>
github page [1] that this project references and uses. It changed quite a l=
ot<br>
in the last 3 years.<br>
<br>
[1] <a href=3D"https://github.com/efficios/latency-tracker" rel=3D"noreferr=
er" target=3D"_blank">https://github.com/efficios/la<wbr>tency-tracker</a><=
/blockquote><div><br></div></span><div>Yes, that is where I downloaded the =
source and followed.=C2=A0</div><span><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><br>
<span class=3D"m_8854001346163611844m_-4183753690866262461gmail-"><br>
<br>
&gt; profiling Process-1 works by providing some useful traces(intermittent=
ly<br>
&gt; kernel panics), but profiling Process-2 the process just hangs.<br>
<br>
</span>What version of lttng-modules are you using? The latency_tracker_dem=
o install<br>
script seems to use lttng-modules 2.6. 2.6 is not supported anymore, it wou=
ld be<br>
interesting to perform you experimentation with a newer version.<br></block=
quote><div><br></div></span><div>Sorry for not being clear in my earlier ms=
g. I did not use the install scripts. All the kernel mdoules, LTTng modules=
, latency-tracker modules and user space libs=C2=A0</div><div>lttng-ust, lt=
tng-tools, lttng-profile was downloaded from git hub few weeks ago and buil=
d from source and loaded.=C2=A0=C2=A0</div><div><br></div><div>From the lat=
ency_tracker_demo, I just built the sleep-demo and used the trace.sh to do =
the tracing</div><span><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
Still, could you provide the panics call stack?<br></blockquote><div><br></=
div></span><div>I do not see a panic trace all the time. In the previous ru=
n, when I tried to kill the Process-2 with &quot;kill -9 &lt;pid&gt;&quot;,=
 as it was hung, the system just rebooted without panic.</div><div><br></di=
v><div><br></div><div>This is from the syslog, and I see the same output on=
 console</div><div><br></div><div><div>1613 Dec 27 16:53:37=C2=A0 kernel: [=
12566.627939] ring buffer relay-metadata: 0 records written, 0 records over=
run</div><div>1614 Dec 27 16:53:37=C2=A0 kernel: [12566.634983] ring buffer=
 relay-metadata, cpu -1: non-consumed data</div><div>1615 Dec 27 16:53:37=
=C2=A0 kernel: [12566.634983]=C2=A0 =C2=A0[ 12288 bytes written, 8192 bytes=
 read ]</div><div>1616 Dec 27 16:53:37=C2=A0 kernel: [12566.646189] ring bu=
ffer: relay-metadata, cpu -1: 8192 bytes committed</div><div>1617 Dec 27 16=
:53:37=C2=A0 kernel: [12566.652780] ring buffer relay-discard, cpu 0: 0 rec=
ords written, 0 records overrun</div><div>1618 Dec 27 16:53:38=C2=A0 kernel=
: [12566.660865] ring buffer relay-discard, cpu 1: 0 records written, 0 rec=
ords overrun</div><div>1619 Dec 27 16:53:38=C2=A0 kernel: [12566.668924] ri=
ng buffer relay-discard, cpu 2: 0 records written, 0 records overrun</div><=
div>1620 Dec 27 16:53:38=C2=A0 kernel: [12566.676897] ring buffer relay-dis=
card, cpu 3: 0 records written, 0 records overrun</div><div>1621 Dec 27 16:=
53:38=C2=A0 kernel: [12566.684809] ring buffer relay-discard, cpu 4: 0 reco=
rds written, 0 records overrun</div><div>1622 Dec 27 16:53:38=C2=A0 kernel:=
 [12566.692681] ring buffer relay-discard, cpu 5: 0 records written, 0 reco=
rds overrun</div><div>1623 Dec 27 16:54:16=C2=A0 avahi-daemon[948]: Registe=
ring new address record for 10.31.33.48 on eth0.IPv4.</div><div>1624 Dec 27=
 16:54:16=C2=A0 rsyslogd-2007: action &#39;action 9&#39; suspended, next re=
try is Wed Dec 27 16:55:46 2017 [v8.16.0 t=C2=A0 =C2=A0 =C2=A0ry <a href=3D=
"http://www.rsyslog.com/e/2007" target=3D"_blank">http://www.rsyslog.com/e/=
2007</a> ]</div><div>1625 Dec 27 16:54:16=C2=A0 systemd-timesyncd[816]: Net=
work configuration changed, trying to establish connection.</div><div>1626 =
Dec 27 16:54:16=C2=A0 systemd-timesyncd[816]: Synchronized to time server <=
a href=3D"http://91.189.94.4:123" target=3D"_blank">91.189.94.4:123</a> (<a=
 href=3D"http://ntp.ubuntu.com" target=3D"_blank">ntp.ubuntu.com</a>).</div=
><div>1627 Dec 27 16:54:17=C2=A0 rsyslogd: [origin software=3D&quot;rsyslog=
d&quot; swVersion=3D&quot;8.16.0&quot; x-pid=3D&quot;924&quot; x-info=3D&qu=
ot;<a href=3D"http://www.rsysl" target=3D"_blank">http://www.rsysl</a>=C2=
=A0 =C2=A0 =C2=A0<a href=3D"http://og.com" target=3D"_blank">og.com</a>&quo=
t;] start=C2=A0</div><div>1628 Dec 27 16:54:17=C2=A0 rsyslogd-2222: command=
 &#39;KLogPermitNonKernelFacility&#39; is currently not permitted - did you=
 alr=C2=A0 =C2=A0 =C2=A0eady set it via a RainerScript command (v6+ config)=
? [v8.16.0 try <a href=3D"http://www.rsyslog.com/e/2222" target=3D"_blank">=
http://www.rsyslog.com/e/2222</a> ]</div><div>1629 Dec 27 16:54:17=C2=A0 rs=
yslogd: rsyslogd&#39;s groupid changed to 115</div><div>1630 Dec 27 16:54:1=
7=C2=A0 rsyslogd: rsyslogd&#39;s userid changed to 108</div><div>1631 Dec 2=
7 16:54:17=C2=A0 kernel: [=C2=A0 =C2=A0 0.000000] Booting Linux on physical=
 CPU 0x100=C2=A0</div><div>1632 Dec 27 16:54:17=C2=A0 kernel: [=C2=A0 =C2=
=A0 0.000000] Initializing cgroup subsys cpuset</div><div>1633 Dec 27 16:54=
:17=C2=A0 kernel: [=C2=A0 =C2=A0 0.000000] Initializing cgroup subsys cpu</=
div><div>1634 Dec 27 16:54:17=C2=A0 kernel: [=C2=A0 =C2=A0 0.000000] Initia=
lizing cgroup subsys cpuacct</div><div>1635 Dec 27 16:54:17=C2=A0 kernel: [=
=C2=A0 =C2=A0 0.000000] Linux version 4.4.38-rt49-tegra (anup.pemmaiah@anup=
-pemmaiah) (gcc ver=C2=A0 =C2=A0 =C2=A0sion 4.9.2 (GCC) ) #1 SMP PREEMPT RT=
 Thu Nov 30 17:12:21 PST 2017</div><div>1636 Dec 27 16:54:17=C2=A0 kernel: =
[=C2=A0 =C2=A0 0.000000] Boot CPU: AArch64 Processor [411fd073]</div><div>1=
637 Dec 27 16:54:17=C2=A0 kernel: [=C2=A0 =C2=A0 0.000000] earlycon: Early =
serial console at MMIO32</div></div><span><div>=C2=A0<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<span class=3D"m_8854001346163611844m_-4183753690866262461gmail-"><br>
&gt;<br>
&gt; Not sure how updated the above pasted links are, because I notice ther=
e is<br>
&gt; no more usec_threshold parameter and I use the threshold<br>
&gt; in /sys/kernel/debug/latency/sysc<wbr>alls/default/threshold<br>
&gt;<br>
&gt; I understand each situation is different, but was curious if=C2=A0 any=
 of you<br>
&gt; have comments/suggestions that would help in debugging latency related=
<br>
&gt; issues using LTTng. I have looked many places to get required info but=
 of<br>
&gt; not much help.<br>
<br>
</span>Most of the maintainers are on vacation during this part of the year=
 so it might<br>
take some time to get answers. I&#39;m sure that Julien Desfossez will be<b=
r>
interested in your use case.<br>
<br>
Cheers<br></blockquote><div><br></div></span><div>I undersatnd and any sugg=
estions will be very helpful=C2=A0</div><span><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<span class=3D"m_8854001346163611844m_-4183753690866262461gmail-"><br>
&gt;<br>
&gt; Your comments/suggestions will be greatly appreciated.<br>
&gt;<br>
&gt; Thanks<br>
&gt; Anup<br>
<br>
</span>&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/=
mailman/listinfo/lttng-dev</a><br>
<span class=3D"m_8854001346163611844m_-4183753690866262461gmail-HOEnZb"><fo=
nt color=3D"#888888"><br>
<br>
--<br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</font></span></blockquote></span></div><br></div></div>
</blockquote></div><br></div></div></div>

--001a11453638ccd8bf0561f803be--

--===============5858918309826942133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5858918309826942133==--
