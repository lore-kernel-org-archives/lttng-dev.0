From: Phil Wilshire <sysdcs@gmail.com>
Subject: System Hang
Date: Fri, 4 Jan 2013 14:30:03 -0500
Message-ID: <CAGRd_950e3k=8tK_PFTDrkrPADq0qminAu+7_odUh9r-koJ6ug__39601.1489480317$1357327864$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1417424595=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sysdcs@gmail.com>) id 1TrCy1-0002Pu-Ts
	for lttng-dev@lists.lttng.org; Fri, 04 Jan 2013 14:30:10 -0500
Received: by mail-wg0-f49.google.com with SMTP id 15so7538745wgd.4
	for <lttng-dev@lists.lttng.org>; Fri, 04 Jan 2013 11:30:04 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1417424595==
Content-Type: multipart/alternative; boundary=f46d04428e1097474404d27b8169

--f46d04428e1097474404d27b8169
Content-Type: text/plain; charset=ISO-8859-1

Hi,
Just getting back into lttng after quite a few years
I need to set up a continuous trace on a system.

Every 10 seconds I stop one session and start another to give me individual
files for each 10 second segment.
I originally intended to start the next session before stopping the
previous but that was causing the sessond to hang.

Ever so often I can start the trace and the trace file is generated but
ongoing commands to lttng are ignored. The new trace file then grows until
all the disk space is used. sessiond seems to be hung


I have the kernel dmseg log attached and I also have the trace file if
needed


 [  345.223564] LTT state dump thread start
[  345.231033] LTT state dump end
[  353.586011] ring buffer relay-metadata: 3604 records written, 0 records
overrun
[  353.590023] ring buffer relay-discard, cpu 0: 408474 records written, 0
records overrun
[  353.590237] ring buffer relay-discard, cpu 1: 390793 records written, 0
records overrun
[  353.590237] ring buffer relay-discard, cpu 2: 363560 records written, 0
records overrun
[  353.590685] ring buffer relay-discard, cpu 3: 518867 records written, 0
records overrun
[  355.720753] LTTng: state dump begin
[  355.720753] LTT state dump thread start
[  355.732034] LTT state dump end
[  364.111388] ring buffer relay-metadata: 3604 records written, 0 records
overrun
[  364.120334] ring buffer relay-discard, cpu 0: 409693 records written, 0
records overrun
[  364.120334] ring buffer relay-discard, cpu 1: 401971 records written, 0
records overrun
[  364.121438] ring buffer relay-discard, cpu 2: 380074 records written, 0
records overrun
[  364.122187] ring buffer relay-discard, cpu 3: 524538 records written, 0
records overrun
[  366.259690] LTTng: state dump begin
[  366.259690] LTT state dump thread start
[  366.266253] LTT state dump end
[  374.633764] ring buffer relay-metadata: 3604 records written, 0 records
overrun
[  374.640024] ring buffer relay-discard, cpu 0: 430919 records written, 0
records overrun
[  374.640024] ring buffer relay-discard, cpu 1: 387021 records written, 0
records overrun
[  374.641033] ring buffer relay-discard, cpu 2: 370007 records written, 0
records overrun
[  374.641033] ring buffer relay-discard, cpu 3: 528606 records written, 0
records overrun
[  376.795384] LTTng: state dump begin
[  376.795384] LTT state dump thread start
[  601.060274] INFO: task lttng-sessiond:2885 blocked for more than 120
seconds.
[  601.069038] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[  601.077626] lttng-sessiond  D ffff880074456b18     0  2885      1
0x10000000
[  601.085210]  ffff88006c0679f8 0000000000000082 0000000000000001
ffff88007b0a4140
[  601.094031]  ffff88006c0679a8 ffff880074456840 ffff88006c067fd8
ffff88006c067fd8
[  601.105026]  0000000000011c80 ffff880074456840 0000000000000000
ffff88006c067a68
[  601.112170] Call Trace:
[  601.116027]  [<ffffffff812dd423>] schedule+0x5b/0x5d
[  601.121025]  [<ffffffffa01b46cb>] lttng_statedump_start+0x5aa/0x623
[lttng_statedump]
[  601.129035]  [<ffffffff810543c7>] ? abort_exclusive_wait+0x8f/0x8f
[  601.136030]  [<ffffffffa01c03bb>] lttng_session_enable+0x52d/0x55b
[lttng_tracer]
[  601.144034]  [<ffffffff810543c7>] ? abort_exclusive_wait+0x8f/0x8f
[  601.150039]  [<ffffffffa01c0de8>] lttng_session_ioctl+0x15f/0x225
[lttng_tracer]
[  601.158042]  [<ffffffff8123a1c3>] ? sock_recvmsg+0xa4/0xb9
[  601.163185]  [<ffffffff810f37b7>] ? lookup_page_cgroup+0x36/0x4d
[  601.169453]  [<ffffffff81186cf9>] ? cpumask_any_but+0x29/0x38
[  601.175508]  [<ffffffff8109984b>] ? trace_preempt_on+0x12/0x2f
[  601.182031]  [<ffffffff812e15eb>] ? sub_preempt_count+0x97/0xc0
[  601.187735]  [<ffffffff812de9a1>] ? _raw_spin_unlock+0x2a/0x35
[  601.193922]  [<ffffffff810c9767>] ? spin_unlock+0xe/0x10
[  601.200027]  [<ffffffff810caa44>] ? do_wp_page+0x26f/0x563
[  601.206028]  [<ffffffff8109987a>] ? trace_preempt_off+0x12/0x30
[  601.212031]  [<ffffffff812e16c8>] ? add_preempt_count+0xb4/0xcf
[  601.218043]  [<ffffffff810cc320>] ? handle_pte_fault+0x6c6/0x76c
[  601.223737]  [<ffffffff812443a7>] ? verify_iovec+0x52/0xa3
[  601.229426]  [<ffffffff810cc6cc>] ? handle_mm_fault+0x199/0x1a9
[  601.236033]  [<ffffffff812e14d3>] ? do_page_fault+0x2f6/0x377
[  601.242034]  [<ffffffffa01c4f8d>] ?
__event_probe__sys_mprotect+0xf5/0xf5 [lttng_tracer]
[  601.251031]  [<ffffffff8110332a>] vfs_ioctl+0x22/0x3a
[  601.256029]  [<ffffffff81103bb7>] do_vfs_ioctl+0x3c4/0x407
[  601.261188]  [<ffffffff810f6e8e>] ? fget_light+0x91/0x9d
[  601.267026]  [<ffffffff81103c41>] sys_ioctl+0x47/0x6a
[  601.272050]  [<ffffffff812e377f>] tracesys+0xd9/0xde


cat /proc/cpuinfo

processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 28
model name : Intel(R) Atom(TM) CPU D525   @ 1.80GHz
stepping : 10
microcode : 0x107
cpu MHz : 1799.823
cache size : 512 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 10
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm
constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64
monitor ds_cpl tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dts
bogomips : 1775.61
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

(repeated for 3 other cpus )

 uname -a
Linux  3.2.21-x510v1 #1 SMP PREEMPT Thu Dec 20 11:24:36 EST 2012 x86_64
GNU/Linux

Script used to run trace
=================================================
#!/bin/sh

xx=`/bin/date +"%s"`
yy="yy"
zz="zz"
log_xx=/home/pswuser/trace/log/psw-${xx}.log
log_yy=/home/pswuser/trace/log/psw-${yy}.log
log_zz=/home/pswuser/trace/log/psw-${zz}.log
#depmod
mkdir -p /home/pswuser/trace
mount -t tmpfs -o size=500M tmpfs /home/pswuser/trace
mkdir -p /home/pswuser/trace/log
touch /home/pswuser/trace/run_trace
sleep 20
if [ -f /home/pswuser/trace/run_trace ] ; then

   echo "lttng create" > ${log_xx}
   lttng create psw-${xx} \
      -o /home/pswuser/trace/psw-${xx} >> ${log_xx} 2>&1
   echo "lttng enable-event" >> ${log_xx}
   sleep 1
   lttng enable-event -a -k  -s psw-${xx} >> ${log_xx} 2>&1
   sleep 1
   echo "lttng start" >> ${log_xx}
   lttng start psw-${xx} >> ${log_xx} 2>&1
   sleep 1

fi

while [ 1 -gt 0 ] ; do
   sleep 7
   yy=`/bin/date +"%s"`
   log_yy=/home/pswuser/trace/log/psw-${yy}.log


#stop xx
   if [ -d /home/pswuser/trace/psw-${xx} ] ; then
      echo "lttng stop" >> ${log_xx}
      lttng stop psw-${xx} >> ${log_xx} 2>&1
      sleep 1
      echo "lttng destroy" >> ${log_xx}
      lttng destroy psw-${xx} >> ${log_xx} 2>&1
      echo "lttng done" >> ${log_xx}
   fi

# start yy after stopping xx
   if [ -f /home/pswuser/trace/run_trace ] ; then
      echo "lttng create ${yy} after closing ${xx}" > ${log_yy}
      lttng create psw-${yy} \
         -o /home/pswuser/trace/psw-${yy} >> ${log_yy} 2>&1
      sleep 1
      echo "lttng enable_event" >> ${log_yy}
      lttng enable-event -a -k -s psw-${yy} >> ${log_yy} 2>&1
      sleep 1
      echo "lttng start" >> ${log_yy}
      lttng start psw-${yy} >> ${log_yy} 2>&1
   fi
# check zz
# delete unless detected or detected2 is present
   if [ ! -f /home/pswuser/bin/delay-detected ] &&
      [ ! -f /home/pswuser/bin/delay-detected2 ] ; then
      echo "lttng delete files" >> ${log_zz}
     rm -rf /home/pswuser/trace/psw-${zz}* >> ${log_zz} 2>&1
     #if [ $? -eq 0 ] ; then rm ${log_zz} ; fi
   fi
# delete second snapshot
   if [ -f /home/pswuser/bin/delay-detected2 ] ; then
     rm -f /home/pswuser/bin/delay-detected2

# no more tracing once event detected
     rm -f /home/pswuser/trace/run_trace
   fi
# trigger second snapshot delete first snapshot
   if [ -f /home/pswuser/bin/delay-detected ] ; then
     rm -f /home/pswuser/bin/delay-detected
     touch /home/pswuser/bin/delay-detected2
   fi

#   ls -l /lttng-traces/psw-*
   # zz (delete candidate) is old xx
   echo "xx ${xx} yy ${yy} zz ${zz}"
   zz=${xx}
   log_zz=$log_xx

  # xx is now the new one
   xx=${yy}
   log_xx=$log_yy

# check disk use
   if [ -d /home/pswuser/trace ] ; then
     du -h /home/pswuser/trace
   fi


done
----------------------------------------

Any clues are welcome.

Another question.

Would it be possible to do this by setting up a ring buffer that will wrap
around after a certain time. I can easily timestamp the event I am looking
for and then capture the buffer containing the event.


Regards
   Phil Wilshire

--f46d04428e1097474404d27b8169
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div style>Just getting back into lttng after quite a f=
ew years</div><div style>I need to set up a continuous trace on a system.</=
div><div style><br></div><div style>Every 10 seconds I stop one session and=
 start another to give me individual files for each 10 second segment.</div=
>
<div style>I originally intended to start the next session before stopping =
the previous but that was causing the sessond to hang.</div><div style><br>=
</div><div style>Ever so often I can start the trace and the trace file is =
generated but ongoing commands to lttng are ignored. The new trace file the=
n grows until all the disk space is used. sessiond seems to be hung</div>
<div style><br></div><div style><br></div><div style>I have the kernel dmse=
g log attached and I also have the trace file if needed</div><div style><br=
></div><div style><br></div><div style>=A0[ =A0345.223564] LTT state dump t=
hread start</div>
<div>[ =A0345.231033] LTT state dump end</div><div>[ =A0353.586011] ring bu=
ffer relay-metadata: 3604 records written, 0 records overrun</div><div>[ =
=A0353.590023] ring buffer relay-discard, cpu 0: 408474 records written, 0 =
records overrun</div>
<div>[ =A0353.590237] ring buffer relay-discard, cpu 1: 390793 records writ=
ten, 0 records overrun</div><div>[ =A0353.590237] ring buffer relay-discard=
, cpu 2: 363560 records written, 0 records overrun</div><div>[ =A0353.59068=
5] ring buffer relay-discard, cpu 3: 518867 records written, 0 records over=
run</div>
<div>[ =A0355.720753] LTTng: state dump begin</div><div>[ =A0355.720753] LT=
T state dump thread start</div><div>[ =A0355.732034] LTT state dump end</di=
v><div>[ =A0364.111388] ring buffer relay-metadata: 3604 records written, 0=
 records overrun</div>
<div>[ =A0364.120334] ring buffer relay-discard, cpu 0: 409693 records writ=
ten, 0 records overrun</div><div>[ =A0364.120334] ring buffer relay-discard=
, cpu 1: 401971 records written, 0 records overrun</div><div>[ =A0364.12143=
8] ring buffer relay-discard, cpu 2: 380074 records written, 0 records over=
run</div>
<div>[ =A0364.122187] ring buffer relay-discard, cpu 3: 524538 records writ=
ten, 0 records overrun</div><div>[ =A0366.259690] LTTng: state dump begin</=
div><div>[ =A0366.259690] LTT state dump thread start</div><div>[ =A0366.26=
6253] LTT state dump end</div>
<div>[ =A0374.633764] ring buffer relay-metadata: 3604 records written, 0 r=
ecords overrun</div><div>[ =A0374.640024] ring buffer relay-discard, cpu 0:=
 430919 records written, 0 records overrun</div><div>[ =A0374.640024] ring =
buffer relay-discard, cpu 1: 387021 records written, 0 records overrun</div=
>
<div>[ =A0374.641033] ring buffer relay-discard, cpu 2: 370007 records writ=
ten, 0 records overrun</div><div>[ =A0374.641033] ring buffer relay-discard=
, cpu 3: 528606 records written, 0 records overrun</div><div>[ =A0376.79538=
4] LTTng: state dump begin</div>
<div>[ =A0376.795384] LTT state dump thread start</div><div>[ =A0601.060274=
] INFO: task lttng-sessiond:2885 blocked for more than 120 seconds.</div><d=
iv>[ =A0601.069038] &quot;echo 0 &gt; /proc/sys/kernel/hung_task_timeout_se=
cs&quot; disables this message.</div>
<div>[ =A0601.077626] lttng-sessiond =A0D ffff880074456b18 =A0 =A0 0 =A0288=
5 =A0 =A0 =A01 0x10000000</div><div>[ =A0601.085210] =A0ffff88006c0679f8 00=
00000000000082 0000000000000001 ffff88007b0a4140</div><div>[ =A0601.094031]=
 =A0ffff88006c0679a8 ffff880074456840 ffff88006c067fd8 ffff88006c067fd8</di=
v>
<div>[ =A0601.105026] =A00000000000011c80 ffff880074456840 0000000000000000=
 ffff88006c067a68</div><div>[ =A0601.112170] Call Trace:</div><div>[ =A0601=
.116027] =A0[&lt;ffffffff812dd423&gt;] schedule+0x5b/0x5d</div><div>[ =A060=
1.121025] =A0[&lt;ffffffffa01b46cb&gt;] lttng_statedump_start+0x5aa/0x623 [=
lttng_statedump]</div>
<div>[ =A0601.129035] =A0[&lt;ffffffff810543c7&gt;] ? abort_exclusive_wait+=
0x8f/0x8f</div><div>[ =A0601.136030] =A0[&lt;ffffffffa01c03bb&gt;] lttng_se=
ssion_enable+0x52d/0x55b [lttng_tracer]</div><div>[ =A0601.144034] =A0[&lt;=
ffffffff810543c7&gt;] ? abort_exclusive_wait+0x8f/0x8f</div>
<div>[ =A0601.150039] =A0[&lt;ffffffffa01c0de8&gt;] lttng_session_ioctl+0x1=
5f/0x225 [lttng_tracer]</div><div>[ =A0601.158042] =A0[&lt;ffffffff8123a1c3=
&gt;] ? sock_recvmsg+0xa4/0xb9</div><div>[ =A0601.163185] =A0[&lt;ffffffff8=
10f37b7&gt;] ? lookup_page_cgroup+0x36/0x4d</div>
<div>[ =A0601.169453] =A0[&lt;ffffffff81186cf9&gt;] ? cpumask_any_but+0x29/=
0x38</div><div>[ =A0601.175508] =A0[&lt;ffffffff8109984b&gt;] ? trace_preem=
pt_on+0x12/0x2f</div><div>[ =A0601.182031] =A0[&lt;ffffffff812e15eb&gt;] ? =
sub_preempt_count+0x97/0xc0</div>
<div>[ =A0601.187735] =A0[&lt;ffffffff812de9a1&gt;] ? _raw_spin_unlock+0x2a=
/0x35</div><div>[ =A0601.193922] =A0[&lt;ffffffff810c9767&gt;] ? spin_unloc=
k+0xe/0x10</div><div>[ =A0601.200027] =A0[&lt;ffffffff810caa44&gt;] ? do_wp=
_page+0x26f/0x563</div>
<div>[ =A0601.206028] =A0[&lt;ffffffff8109987a&gt;] ? trace_preempt_off+0x1=
2/0x30</div><div>[ =A0601.212031] =A0[&lt;ffffffff812e16c8&gt;] ? add_preem=
pt_count+0xb4/0xcf</div><div>[ =A0601.218043] =A0[&lt;ffffffff810cc320&gt;]=
 ? handle_pte_fault+0x6c6/0x76c</div>
<div>[ =A0601.223737] =A0[&lt;ffffffff812443a7&gt;] ? verify_iovec+0x52/0xa=
3</div><div>[ =A0601.229426] =A0[&lt;ffffffff810cc6cc&gt;] ? handle_mm_faul=
t+0x199/0x1a9</div><div>[ =A0601.236033] =A0[&lt;ffffffff812e14d3&gt;] ? do=
_page_fault+0x2f6/0x377</div>
<div>[ =A0601.242034] =A0[&lt;ffffffffa01c4f8d&gt;] ? __event_probe__sys_mp=
rotect+0xf5/0xf5 [lttng_tracer]</div><div>[ =A0601.251031] =A0[&lt;ffffffff=
8110332a&gt;] vfs_ioctl+0x22/0x3a</div><div>[ =A0601.256029] =A0[&lt;ffffff=
ff81103bb7&gt;] do_vfs_ioctl+0x3c4/0x407</div>
<div>[ =A0601.261188] =A0[&lt;ffffffff810f6e8e&gt;] ? fget_light+0x91/0x9d<=
/div><div>[ =A0601.267026] =A0[&lt;ffffffff81103c41&gt;] sys_ioctl+0x47/0x6=
a</div><div>[ =A0601.272050] =A0[&lt;ffffffff812e377f&gt;] tracesys+0xd9/0x=
de</div>
<div><br></div><div style><br></div><div><div>cat /proc/cpuinfo=A0</div><di=
v><br></div><div>processor<span class=3D"" style=3D"white-space:pre">	</spa=
n>: 0</div><div>vendor_id<span class=3D"" style=3D"white-space:pre">	</span=
>: GenuineIntel</div>
<div>cpu family<span class=3D"" style=3D"white-space:pre">	</span>: 6</div>=
<div>model<span class=3D"" style=3D"white-space:pre">		</span>: 28</div><di=
v>model name<span class=3D"" style=3D"white-space:pre">	</span>: Intel(R) A=
tom(TM) CPU D525 =A0 @ 1.80GHz</div>
<div>stepping<span class=3D"" style=3D"white-space:pre">	</span>: 10</div><=
div>microcode<span class=3D"" style=3D"white-space:pre">	</span>: 0x107</di=
v><div>cpu MHz<span class=3D"" style=3D"white-space:pre">		</span>: 1799.82=
3</div><div>
cache size<span class=3D"" style=3D"white-space:pre">	</span>: 512 KB</div>=
<div>physical id<span class=3D"" style=3D"white-space:pre">	</span>: 0</div=
><div>siblings<span class=3D"" style=3D"white-space:pre">	</span>: 4</div><=
div>core id<span class=3D"" style=3D"white-space:pre">		</span>: 0</div>
<div>cpu cores<span class=3D"" style=3D"white-space:pre">	</span>: 2</div><=
div>apicid<span class=3D"" style=3D"white-space:pre">		</span>: 0</div><div=
>initial apicid<span class=3D"" style=3D"white-space:pre">	</span>: 0</div>=
<div>fpu<span class=3D"" style=3D"white-space:pre">		</span>: yes</div>
<div>fpu_exception<span class=3D"" style=3D"white-space:pre">	</span>: yes<=
/div><div>cpuid level<span class=3D"" style=3D"white-space:pre">	</span>: 1=
0</div><div>wp<span class=3D"" style=3D"white-space:pre">		</span>: yes</di=
v><div>flags<span class=3D"" style=3D"white-space:pre">		</span>: fpu vme d=
e pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts =
acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon=
 pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3 cx16=
 xtpr pdcm movbe lahf_lm dts</div>
<div>bogomips<span class=3D"" style=3D"white-space:pre">	</span>: 1775.61</=
div><div>clflush size<span class=3D"" style=3D"white-space:pre">	</span>: 6=
4</div><div>cache_alignment<span class=3D"" style=3D"white-space:pre">	</sp=
an>: 64</div>
<div>address sizes<span class=3D"" style=3D"white-space:pre">	</span>: 36 b=
its physical, 48 bits virtual</div><div>power management:</div><div><br></d=
iv></div><div style>(repeated for 3 other cpus )</div><div style><div><br><=
/div>
<div>=A0uname -a</div><div>Linux =A03.2.21-x510v1 #1 SMP PREEMPT Thu Dec 20=
 11:24:36 EST 2012 x86_64 GNU/Linux</div><div><br></div><div style>Script u=
sed to run trace</div><div style><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>#!/bin/sh</div><div><br></div><div>xx=3D`/bin/date +&quot;%s&quot;`</d=
iv><div>yy=3D&quot;yy&quot;</div><div>zz=3D&quot;zz&quot;</div><div>log_xx=
=3D/home/pswuser/trace/log/psw-${xx}.log</div><div>log_yy=3D/home/pswuser/t=
race/log/psw-${yy}.log</div>
<div>log_zz=3D/home/pswuser/trace/log/psw-${zz}.log</div><div>#depmod</div>=
<div>mkdir -p /home/pswuser/trace</div><div>mount -t tmpfs -o size=3D500M t=
mpfs /home/pswuser/trace</div><div>mkdir -p /home/pswuser/trace/log</div><d=
iv>
touch /home/pswuser/trace/run_trace</div><div>sleep 20<br></div><div>if [ -=
f /home/pswuser/trace/run_trace ] ; then=A0</div><div><br></div><div>=A0 =
=A0echo &quot;lttng create&quot; &gt; ${log_xx}</div><div>=A0 =A0lttng crea=
te psw-${xx} \</div>
<div>=A0 =A0 =A0 -o /home/pswuser/trace/psw-${xx} &gt;&gt; ${log_xx} 2&gt;&=
amp;1</div><div>=A0 =A0echo &quot;lttng enable-event&quot; &gt;&gt; ${log_x=
x}</div><div>=A0 =A0sleep 1</div><div>=A0 =A0lttng enable-event -a -k =A0-s=
 psw-${xx} &gt;&gt; ${log_xx} 2&gt;&amp;1</div>
<div>=A0 =A0sleep 1</div><div>=A0 =A0echo &quot;lttng start&quot; &gt;&gt; =
${log_xx}</div><div>=A0 =A0lttng start psw-${xx} &gt;&gt; ${log_xx} 2&gt;&a=
mp;1</div><div>=A0 =A0sleep 1</div><div><br></div><div>fi</div><div><br></d=
iv><div>while [ 1 -gt 0 ] ; do</div>
<div>=A0 =A0sleep 7</div><div>=A0 =A0yy=3D`/bin/date +&quot;%s&quot;`</div>=
<div>=A0 =A0log_yy=3D/home/pswuser/trace/log/psw-${yy}.log</div><div><br></=
div><div><br></div><div>#stop xx</div><div>=A0 =A0if [ -d /home/pswuser/tra=
ce/psw-${xx} ] ; then=A0</div>
<div>=A0 =A0 =A0 echo &quot;lttng stop&quot; &gt;&gt; ${log_xx}</div><div>=
=A0 =A0 =A0 lttng stop psw-${xx} &gt;&gt; ${log_xx} 2&gt;&amp;1</div><div>=
=A0 =A0 =A0 sleep 1</div><div>=A0 =A0 =A0 echo &quot;lttng destroy&quot; &g=
t;&gt; ${log_xx}</div>
<div>=A0 =A0 =A0 lttng destroy psw-${xx} &gt;&gt; ${log_xx} 2&gt;&amp;1</di=
v><div>=A0 =A0 =A0 echo &quot;lttng done&quot; &gt;&gt; ${log_xx}</div><div=
>=A0 =A0fi</div><div><br></div><div># start yy after stopping xx=A0</div><d=
iv>=A0 =A0if [ -f /home/pswuser/trace/run_trace ] ; then=A0</div>
<div>=A0 =A0 =A0 echo &quot;lttng create ${yy} after closing ${xx}&quot; &g=
t; ${log_yy}</div><div>=A0 =A0 =A0 lttng create psw-${yy} \</div><div>=A0 =
=A0 =A0 =A0 =A0-o /home/pswuser/trace/psw-${yy} &gt;&gt; ${log_yy} 2&gt;&am=
p;1</div><div>=A0 =A0 =A0 sleep 1</div>
<div>=A0 =A0 =A0 echo &quot;lttng enable_event&quot; &gt;&gt; ${log_yy}</di=
v><div>=A0 =A0 =A0 lttng enable-event -a -k -s psw-${yy} &gt;&gt; ${log_yy}=
 2&gt;&amp;1</div><div>=A0 =A0 =A0 sleep 1</div><div>=A0 =A0 =A0 echo &quot=
;lttng start&quot; &gt;&gt; ${log_yy}</div>
<div>=A0 =A0 =A0 lttng start psw-${yy} &gt;&gt; ${log_yy} 2&gt;&amp;1</div>=
<div>=A0 =A0fi</div><div># check zz</div><div># delete unless detected or d=
etected2 is present</div><div>=A0 =A0if [ ! -f /home/pswuser/bin/delay-dete=
cted ] &amp;&amp;</div>
<div>=A0 =A0 =A0 [ ! -f /home/pswuser/bin/delay-detected2 ] ; then</div><di=
v>=A0 =A0 =A0 echo &quot;lttng delete files&quot; &gt;&gt; ${log_zz}</div><=
div>=A0 =A0 =A0rm -rf /home/pswuser/trace/psw-${zz}* &gt;&gt; ${log_zz} 2&g=
t;&amp;1</div>
<div>=A0 =A0 =A0#if [ $? -eq 0 ] ; then rm ${log_zz} ; fi</div><div>=A0 =A0=
fi</div><div># delete second snapshot</div><div>=A0 =A0if [ -f /home/pswuse=
r/bin/delay-detected2 ] ; then</div><div>=A0 =A0 =A0rm -f /home/pswuser/bin=
/delay-detected2</div>
<div><br></div><div># no more tracing once event detected=A0</div><div>=A0 =
=A0 =A0rm -f /home/pswuser/trace/run_trace</div><div>=A0 =A0fi<br></div><di=
v># trigger second snapshot delete first snapshot</div><div>=A0 =A0if [ -f =
/home/pswuser/bin/delay-detected ] ; then</div>
<div>=A0 =A0 =A0rm -f /home/pswuser/bin/delay-detected</div><div>=A0 =A0 =
=A0touch /home/pswuser/bin/delay-detected2</div><div>=A0 =A0fi</div><div><b=
r></div><div># =A0 ls -l /lttng-traces/psw-*</div><div>=A0 =A0# zz (delete =
candidate) is old xx=A0</div>
<div>=A0 =A0echo &quot;xx ${xx} yy ${yy} zz ${zz}&quot;</div><div>=A0 =A0zz=
=3D${xx}</div><div>=A0 =A0log_zz=3D$log_xx</div><div>=A0</div><div>=A0 # xx=
 is now the new one</div><div>=A0 =A0xx=3D${yy}</div><div>=A0 =A0log_xx=3D$=
log_yy</div><div><br></div><div style>
# check disk use</div><div>=A0 =A0if [ -d /home/pswuser/trace ] ; then=A0</=
div><div>=A0 =A0 =A0du -h /home/pswuser/trace</div><div>=A0 =A0fi</div><div=
><br></div><div><br></div><div>done</div><div>-----------------------------=
-----------</div>
</div><div style><br></div><div style>Any clues are welcome.</div><div styl=
e><br></div><div style>Another question.</div><div style><br></div><div sty=
le>Would it be possible to do this by setting up a ring buffer that will wr=
ap around after a certain time. I can easily timestamp the event I am looki=
ng for and then capture the buffer containing the event.</div>
<div style><br></div><div style>=A0=A0 =A0</div><div style>Regards</div><di=
v style>=A0 =A0Phil Wilshire</div><div style><br></div></div></div>

--f46d04428e1097474404d27b8169--


--===============1417424595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1417424595==--
