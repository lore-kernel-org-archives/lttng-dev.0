From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lost trace events
Date: Thu, 8 Nov 2018 11:05:42 -0500
Message-ID: <20181108160542.GB12330__22541.2294072614$1541693028$gmane$org@joraj-alpa>
References: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
 <20181107153120.GA15594@joraj-alpa>
 <CADwgpi9Hpm9hYuRi9y9qOVyUvoGWcVkX0ZEm6AvQaPyeN_QWkQ@mail.gmail.com>
 <20181107200929.GA12330@joraj-alpa>
 <CADwgpi9Yc+Z15Pit8M4SDzcj9s8UoA2h1NOW8aXgqrRdSfhqYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rSn41nKzzpps
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 11:05:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CADwgpi9Yc+Z15Pit8M4SDzcj9s8UoA2h1NOW8aXgqrRdSfhqYw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alok Priyadarshi <alokpr@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> A custom trace event class emits "begin" and "end" events in its
> constructor and destructor respectively. So I do not think this is due to
> conditional path.

If you can guarantee that the destructor is called, seems good to me.

Do you see scenario where the "begin" event is missing ?

> 
> Sequence of commands to capture a snapshot are:
> lttng create --snapshot
> lttng enable-event --userspace --all
> lttng add-context --userspace -t vpid -t vtid
> lttng start
> lttng stop
> lttng snapshot record

Nothing out of the ordinary here.

> 
> We create a new session for each snapshot to make sure that the buffer does
> not have any left-over events from the previous session. But I am curious
> if lttng shares buffers between sessions or re-uses buffers from an old
> session without flushing?

No sharing is done between sessions AFAIK.

> 
> Note that I am using the default LTTNG_BUFFER_PER_UID mode. All processes
> for our application run under one UID, and only one tracing session is
> active at a time.

Again, nothing out of the ordinary.

Next step would be a small reproducer.

Is the system under load?
Is there any cpu affinity set?
What kind of system are we talking about (x86_64? arm? 24+ cores? etc.)

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
