From: Yiteng Guo <guoyiteng@gmail.com>
Subject: Re: HugePages shared memory support in LLTng
Date: Mon, 22 Jul 2019 14:44:09 -0400
Message-ID: <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ__37576.7781444424$1563821077$gmane$org@mail.gmail.com>
References: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
 <20190715143302.GA2017@joraj-alpa>
 <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by lists.lttng.org (Postfix) with ESMTPS id 45sr9x5K4Jz16hx
 for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2019 14:44:21 -0400 (EDT)
Received: by mail-wr1-x444.google.com with SMTP id r1so40472800wrl.7
 for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2019 11:44:21 -0700 (PDT)
In-Reply-To: <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
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

Hi Jonathan,

I spent these days on this problem and finally figured it out. Here
are patches I've written.

https://github.com/lttng/lttng-ust/compare/master...guoyiteng:hugepages
https://github.com/lttng/lttng-tools/compare/master...guoyiteng:hugepages

These two patches are just ad-hoc supports for hugepages, which are
not intended to be a pull request. If you want to support hugepages in
future lttng releases, I am glad to help you with that. What I did
here is to replace `shm_open` with `open` on a hugetlbfs directory. I
also modified other parts of code (such as memory alignment) to make
them compatible with huge pages. I didn't use `shm-path` option
because I noticed that this option would not only relocate the shm of
ring buffer but also other shm and metadata files. However, we only
wanted to use huge pages for ring buffer here. Here are commands I
used to launch an lttng session.

```
lttng create
lttng enable-channel --userspace --subbuf-size=4M --num-subbuf=2
--buffers-pid my-channel
lttng add-context --userspace --type=perf:thread:page-fault
lttng enable-event --userspace -c my-channel hello_world:my_first_tracepoint
lttng start
```

My patches worked very well and I didn't get page faults anymore.
However, the only caveat of this patch is that ringbuffers are not
destroyed correctly. It leads to a problem that every new lttng
session acquires some hugepages but never releases them. After I
created and destroyed several sessions, I would get an error that told
me there were not enough hugepages to be used. I get around this
problem by restarting the session daemon. But there should be some way
to have ringbuffers (or its channel) destroyed elegently when its
session is destroyed.

In the meantime, I am also trying another way to get rid of these page
faults, which is to prefault the ringbuffer shared memory in my
program. This solution does not need any modification on lttng souce
codes, which, I think, is a safer way to go. However, to prefault the
ringbuffer shm, I need to know the address (and size) of the
ringbuffer. Is there any way to learn this piece of information from
the user program?

I wish you could have a plan to support the hugepages in the future. I
am more than happy to help you with that. Thank you very much and I
look forward to hearing from you.

Best,
Yiteng

On Mon, Jul 15, 2019 at 3:21 PM Yiteng Guo <guoyiteng@gmail.com> wrote:
>
> Hi Jonathan,
>
> Thank you for your prompt reply.
>
> On Mon, Jul 15, 2019 at 10:33 AM Jonathan Rajotte-Julien
> <jonathan.rajotte-julien@efficios.com> wrote:
> >
> > Hi Yiteng,
> >
> > On Fri, Jul 12, 2019 at 06:18:44PM -0400, Yiteng Guo wrote:
> > > Hello,
> > >
> > > I am wondering if there is any way for lttng-ust to create its shm on
> > > hugepages. I noticed that there was an option `--shm-path` which can be
> > > used to change the location of shm. However, if I specified the path to a
> > > `hugetlbfs` such as /dev/hugepages, I would get errors in lttng-sessiond
> > > and no trace data were generated.
> > >
> > > The error I got was
> > > ```
> > > PERROR - 17:54:56.740674 [8163/8168]: Error appending to metadata file:
> > > Invalid argument (in lttng_metadata_printf() at ust-metadata.c:176)
> > > Error: Failed to generate session metadata (errno = -1)
> > > ```
> > > I took a look at lttng code base and found that lttng used `write` to
> > > generate a metadata file under `--shm-path`. However, it looks like
> > > `hugetlbfs` does not support `write` operation. I did a simple patch with
> > > `mmap` to get around this problem. Then, I got another error:
> >
> > Would you be interested in sharing this patch so we can help you figure out the
> > problem?
> >
> > A github branch would be perfect.
> >
>
> You can check out my patch here:
> https://github.com/guoyiteng/lttng-tools/compare/master...guoyiteng:hugepage
>
> > > ```
> > > Error: Error creating UST channel "my-channel" on the consumer daemon
> > > ```
> >
> > Make sure to pass "--verbose-consumer" to lttng-sessiond. It will ensure that
> > the lttng-consumerd output is present in lttng-sesssiond logs. It should help a
> > bit
> >
> > I suspect that we fail on buffers allocation.
> >
>
> After I passed "--verbose-consumer", I got the following logs.
>
> DEBUG1 - 18:59:55.773387304 [8844/8844]: Health check time delta in
> seconds set to 20 (in health_init() at health.c:73)
> DEBUG3 - 18:59:55.773544396 [8844/8844]: Created hashtable size 4 at
> 0x5625c427d4c0 of type 2 (in lttng_ht_new() at hashtable.c:145)
> DEBUG3 - 18:59:55.773560630 [8844/8844]: Created hashtable size 4 at
> 0x5625c427dc00 of type 2 (in lttng_ht_new() at hashtable.c:145)
> DEBUG3 - 18:59:55.773566277 [8844/8844]: Created hashtable size 4 at
> 0x5625c427df30 of type 2 (in lttng_ht_new() at hashtable.c:145)
> DEBUG3 - 18:59:55.773572450 [8844/8844]: Created hashtable size 4 at
> 0x5625c427ead0 of type 2 (in lttng_ht_new() at hashtable.c:145)
> DEBUG3 - 18:59:55.773576515 [8844/8844]: Created hashtable size 4 at
> 0x5625c427f210 of type 2 (in lttng_ht_new() at hashtable.c:145)
> DEBUG3 - 18:59:55.773582290 [8844/8844]: Created hashtable size 4 at
> 0x5625c427f950 of type 2 (in lttng_ht_new() at hashtable.c:145)
> DEBUG1 - 18:59:55.773605669 [8844/8844]: TCP inet operation timeout
> set to 216 sec (in lttcomm_inet_init() at inet.c:546)
> DEBUG1 - 18:59:55.773627249 [8844/8844]: Connecting to error socket
> /home/vagrant/.lttng/ustconsumerd64/error (in main() at
> lttng-consumerd.c:464)
> DEBUG1 - 18:59:55.773767487 [8844/8848]: [thread] Manage health check
> started (in thread_manage_health() at health-consumerd.c:167)
> DEBUG1 - 18:59:55.773849241 [8844/8848]: epoll set max size is 1659863
> (in compat_epoll_set_max_size() at compat-epoll.c:337)
> DEBUG1 - 18:59:55.773884368 [8844/8848]: Health check ready (in
> thread_manage_health() at health-consumerd.c:247)
> DEBUG3 - 18:59:55.883547291 [8844/8850]: Created hashtable size 4 at
> 0x7ff5ec000b40 of type 2 (in lttng_ht_new() at hashtable.c:145)
> DEBUG1 - 18:59:55.884682278 [8844/8850]: Thread channel poll started
> (in consumer_thread_channel_poll() at consumer.c:2941)
> DEBUG1 - 18:59:55.883573028 [8844/8853]: Creating command socket
> /home/vagrant/.lttng/ustconsumerd64/command (in
> consumer_thread_sessiond_poll() at consumer.c:3204)
> DEBUG1 - 18:59:55.885435478 [8844/8853]: Sending ready command to
> lttng-sessiond (in consumer_thread_sessiond_poll() at consumer.c:3217)
> DEBUG1 - 18:59:55.883646301 [8844/8852]: Updating poll fd array (in
> update_poll_array() at consumer.c:1103)
> DEBUG1 - 18:59:55.885574718 [8844/8853]: Connection on client_socket
> (in consumer_thread_sessiond_poll() at consumer.c:3239)
> DEBUG1 - 18:59:55.885583183 [8844/8852]: polling on 2 fd (in
> consumer_thread_data_poll() at consumer.c:2630)
> DEBUG1 - 18:59:55.885596572 [8844/8853]: Metadata connection on
> client_socket (in set_metadata_socket() at consumer.c:3165)
> DEBUG1 - 18:59:55.885612073 [8844/8853]: Incoming command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3285)
> DEBUG1 - 18:59:55.883553158 [8844/8851]: Thread metadata poll started
> (in consumer_thread_metadata_poll() at consumer.c:2351)
> DEBUG1 - 18:59:55.885714717 [8844/8851]: Metadata main loop started
> (in consumer_thread_metadata_poll() at consumer.c:2367)
> DEBUG1 - 18:59:55.885726270 [8844/8851]: Metadata poll wait (in
> consumer_thread_metadata_poll() at consumer.c:2373)
> DEBUG1 - 18:59:55.885781919 [8844/8853]: Received channel monitor pipe
> (29) (in lttng_ustconsumer_recv_cmd() at ust-consumer.c:1903)
> DEBUG1 - 18:59:55.885803340 [8844/8853]: Channel monitor pipe set as
> non-blocking (in lttng_ustconsumer_recv_cmd() at ust-consumer.c:1924)
> DEBUG1 - 18:59:55.885810860 [8844/8853]: received command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3301)
> DEBUG1 - 18:59:55.887146328 [8844/8850]: Channel main loop started (in
> consumer_thread_channel_poll() at consumer.c:2956)
> DEBUG1 - 18:59:55.887497303 [8844/8850]: Channel poll wait (in
> consumer_thread_channel_poll() at consumer.c:2961)
> DEBUG1 - 18:59:55.892440821 [8844/8853]: Incoming command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3285)
> DEBUG1 - 18:59:55.892479711 [8844/8853]: Consumer mkdir
> /home/vagrant/lttng-traces/auto-20190715-185955//ust in session 0 (in
> lttng_ustconsumer_recv_cmd() at ust-consumer.c:2093)
> DEBUG3 - 18:59:55.892486547 [8844/8853]: mkdirat() recursive fd = -100
> (AT_FDCWD), path =
> /home/vagrant/lttng-traces/auto-20190715-185955//ust, mode = 504, uid
> = 1000, gid = 1000 (in run_as_mkdirat_recursive() at runas.c:1147)
> DEBUG1 - 18:59:55.892500964 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG1 - 18:59:55.892852801 [8844/8853]: received command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3301)
> DEBUG1 - 18:59:57.964977091 [8844/8853]: Incoming command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3285)
> DEBUG1 - 18:59:57.965041124 [8844/8853]: Allocated channel (key 1) (in
> consumer_allocate_channel() at consumer.c:1043)
> DEBUG3 - 18:59:57.965052309 [8844/8853]: Creating channel to ustctl
> with attr: [overwrite: 0, subbuf_size: 524288, num_subbuf: 4,
> switch_timer_interval: 0, read_timer_interval: 0, output: 0, type: 0
> (in create_ust_channel() at ust-consumer.c:457)
> DEBUG3 - 18:59:57.965104805 [8844/8853]: open()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_0
> with flags C2 mode 384 for uid 1000 and gid 1000 (in run_as_open() at
> runas.c:1212)
> DEBUG1 - 18:59:57.965120609 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.965317517 [8844/8853]: open()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_1
> with flags C2 mode 384 for uid 1000 and gid 1000 (in run_as_open() at
> runas.c:1212)
> DEBUG1 - 18:59:57.965335148 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.965445811 [8844/8853]: open()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_2
> with flags C2 mode 384 for uid 1000 and gid 1000 (in run_as_open() at
> runas.c:1212)
> DEBUG1 - 18:59:57.965461438 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.966116363 [8844/8853]: open()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_3
> with flags C2 mode 384 for uid 1000 and gid 1000 (in run_as_open() at
> runas.c:1212)
> DEBUG1 - 18:59:57.966145191 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.966341799 [8844/8853]: open()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_4
> with flags C2 mode 384 for uid 1000 and gid 1000 (in run_as_open() at
> runas.c:1212)
> DEBUG1 - 18:59:57.966420313 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.966548533 [8844/8853]: open()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_5
> with flags C2 mode 384 for uid 1000 and gid 1000 (in run_as_open() at
> runas.c:1212)
> DEBUG1 - 18:59:57.966567778 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.966932907 [8844/8853]: unlink()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_5
> with for uid 1000 and gid 1000 (in run_as_unlink() at runas.c:1233)
> DEBUG1 - 18:59:57.966950256 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.967061802 [8844/8853]: unlink()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_4
> with for uid 1000 and gid 1000 (in run_as_unlink() at runas.c:1233)
> DEBUG1 - 18:59:57.967081332 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.967366982 [8844/8853]: unlink()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_3
> with for uid 1000 and gid 1000 (in run_as_unlink() at runas.c:1233)
> DEBUG1 - 18:59:57.967419957 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.967562353 [8844/8853]: unlink()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_2
> with for uid 1000 and gid 1000 (in run_as_unlink() at runas.c:1233)
> DEBUG1 - 18:59:57.967587355 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.968008237 [8844/8853]: unlink()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_1
> with for uid 1000 and gid 1000 (in run_as_unlink() at runas.c:1233)
> DEBUG1 - 18:59:57.968104447 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.968327138 [8844/8853]: unlink()
> /dev/hugepages/auto-20190715-185955/ust/uid/1000/64-bit/channel0_0
> with for uid 1000 and gid 1000 (in run_as_unlink() at runas.c:1233)
> DEBUG1 - 18:59:57.968349750 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG3 - 18:59:57.968562473 [8844/8853]: rmdir_recursive()
> /dev/hugepages/auto-20190715-185955 with for uid 1000 and gid 1000 (in
> run_as_rmdir_recursive() at runas.c:1251)
> DEBUG1 - 18:59:57.968582498 [8844/8853]: Using run_as worker (in
> run_as() at runas.c:1100)
> DEBUG1 - 18:59:57.968934753 [8844/8853]: UST consumer cleaning stream
> list (in destroy_channel() at ust-consumer.c:67)
> DEBUG1 - 18:59:57.969019502 [8844/8853]: received command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3301)
> Error: ask_channel_creation consumer command failed
> Error: Error creating UST channel "channel0" on the consumer daemon
>
> > > This time, I could not locate the problem anymore :(. Do you have any idea
> > > of how to get hugepages shm work in lttng?
> > >
> > > To give you more context here, I was tracing a performance sensitive
> > > program. I didn't want to suffer from the sub-buffer switch cost so I
> > > created a very large sub-buffer (1MB).
> >
> > If you don't mind, how many core are present? How much memory is available on
> > the host?
>
> I compiled and played around with lttng source codes on my vagrant vm
> environment. I assigned 6 cores and 7.8G memory to it. My vm OS is
> Ubuntu 18.04.2 LTS (GNU/Linux 4.15.0-51-generic x86_64).
>
> >
> > Could you share with us the complete sequence of command you use to setup your
> > tracing session?
> >
>
> I used the following commands to test if lttng works with hugepages.
> ```
> lttng create --shm-path=/dev/hugepages
> lttng enable-event --userspace hello_world:my_first_tracepoint
> lttng start
> ```
> And the binary program I traced was the hello_world example in lttng
> documentation page.
>
> > If it is not much trouble could you also share the step you took to setup/mount
> > your hugetlbfs path?
> >
>
> I followed the first section in https://wiki.debian.org/Hugepages to
> set up my hugetlbfs, except I used /dev/hugepages instead of
> /hugepages.
>
> > > I did a benchmark on my tracepoint
> > > and noticed that after running a certain number of tracepoints, I got a
> > > noticeably larger overhead (1200ns larger than other) for every ~130
> > > tracepoints. It turned out that this large overhead was due to a page
> > > fault. The numbers were matched up (130 * 32 bytes = 4160 bytes, which is
> > > approximately the size of a normal page 4kB) and I also used lttng perf
> > > page fault counters to verify it. Therefore, I am looking for a solution to
> > > have lttng create shm on hugepages.
> >
> > Quite interesting!
> >
> > >
> > > Thank you very much! I look forward to hearing from you.
> > >
> > > Best,
> > > Yiteng
> >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> > --
> > Jonathan Rajotte-Julien
> > EfficiOS
>
> Best,
> Yiteng
