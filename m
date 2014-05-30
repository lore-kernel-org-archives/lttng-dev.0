From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Does LTTng UST support ARM?
Date: Fri, 30 May 2014 14:55:30 -0400
Message-ID: <5388D422.9030902__40092.331582173$1401476199$gmane$org@voxpopuli.im>
References: <CAOhR-w31w=er_PfYtGk-QaC+S+iHPgxNH_11iJmKgO6_Bb=Zqw@mail.gmail.com>
 <CAEiAFz23qbrc7GHwHFVWk3Xi3YAzLZtNKaFTb0tbdhX-fTtjMA@mail.gmail.com>
 <CAOhR-w3+L+MKzr1vYoC4JhN7kD1RS6xZVGkrHNphe2TdrjPS=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1WqRxj-0003Yr-81
 for lttng-dev@lists.lttng.org; Fri, 30 May 2014 14:55:36 -0400
In-Reply-To: <CAOhR-w3+L+MKzr1vYoC4JhN7kD1RS6xZVGkrHNphe2TdrjPS=Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


On 05/30/2014 04:53 AM, Hongbo Zhang wrote:
> Thank you Jan.
> Encouraged by the truth that LTTng UST does work on ARM, I paid more
> efforts and run it on my ARM board at last.
>
> I am using a Ubuntu on my board, and I installed lttng-ust and
> userspace-rcu from source codes, but installed lttng-tools by apt-get
> command(the babeltrace was also included I think), the reason I failed to
> trace the lttng-tools from apt-get doesn't work and even doesn't give any
> suggestive output.
> Then I re-installed lttng-tools and babeltrace from source codes again,
> then everything works :)

You need to use lttng-ust and lttng-tools (and lttng-modules if you use 
the kernel tracer) from the same release branch. So everything needs to 
be 2.4.x, or everything 2.3.x, etc.

If you compiled lttng-ust 2.4 from source, but the distro package 
installed lttng-tools let's say 2.2, it's expected that they wouldn't 
work. :)  However I'd suppose some sort of user-friendly message should 
be printed if incompatible versions are used together.

Cheers,
Alexandre
