From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Change of output format in lttng view?
Date: Tue, 21 Apr 2015 16:04:44 -0400
Message-ID: <CAB4xu_13OKQJgisuNSyvRhEZeSXm6hbXiWY2AJws3bdU3yZziw__40327.0899820656$1429646805$gmane$org@mail.gmail.com>
References: <CAJaGzgszPHbfotmpSNWnpChB_jDmvwkFxCST6M=FurcBSRpxcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1YkeQ4-0002qw-RO
 for lttng-dev@lists.lttng.org; Tue, 21 Apr 2015 16:05:28 -0400
Received: by lbbqq2 with SMTP id qq2so164197557lbb.3
 for <lttng-dev@lists.lttng.org>; Tue, 21 Apr 2015 13:05:15 -0700 (PDT)
In-Reply-To: <CAJaGzgszPHbfotmpSNWnpChB_jDmvwkFxCST6M=FurcBSRpxcA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Glen Keane <glenkeane.94@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Apr 21, 2015 at 12:26 PM, Glen Keane <glenkeane.94@gmail.com> wrote:
>
> Hey guys,
>
> Would you please  consider changing the '=' char to a ':' char in the event data output of `lttng view`? it would make it more json-like.

This output format, called ctf-text, is a custom one, even though it
shares similarities with JSON.

The Babeltrace viewer is currently actively being redesigned to
ease the creation of input/output formats thanks to a plugin interface
with a clean API. ctf-text will be available as a plugin, unchanged,
but JSON and YAML output plugins are also on the roadmap, so
stay tuned!

Phil

>
> Currently when you `lttng view` something you get
>
> '[13:17:40.642101755] (+0.000213714) vagrant-ubuntu-trusty-64 node:gc_done: { cpu_id = 0 }, { gctype = "kGCTypeScavenge", gcflags = "kNoGCCallbackFlags" }',
>
> I think that
>
> '[13:17:40.642101755] (+0.000213714) vagrant-ubuntu-trusty-64 node:gc_done: { cpu_id : 0 }, { gctype : "kGCTypeScavenge", gcflags : "kNoGCCallbackFlags" }'
>
> would be better.
>
> Any thoughts? It seems to be very similar to json already. :)
>
> Glen.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
