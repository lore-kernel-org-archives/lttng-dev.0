From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH lttng-tools] Change wfq usages for wfcq
Date: Mon, 28 Jul 2014 15:10:44 -0400
Message-ID: <CAFXXi0m61TdHb5+EC8=kR6yrby5Bw6Sf4UeeZz0WUK37JpsM8g__10041.8859431104$1406574747$gmane$org@mail.gmail.com>
References: <1406352416-11364-1-git-send-email-simon.marchi@polymtl.ca>
 <20140728185019.GF5591@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1XBqKO-0005py-TH
 for lttng-dev@lists.lttng.org; Mon, 28 Jul 2014 15:11:26 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so4167587igb.2
 for <lttng-dev@lists.lttng.org>; Mon, 28 Jul 2014 12:11:15 -0700 (PDT)
In-Reply-To: <20140728185019.GF5591@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 28 July 2014 14:50, David Goulet <dgoulet@efficios.com> wrote:
> So there is quite an issue with that which is that tools does not work
> with urcu 0.7 anymore.
>
> That would mean urcu 0.8 and later would be the requirement from now on.

Ok, so the version number of urcu in configure.ac should be updated too.

> Not sure I'm comfortable with that but again I don't see why we should
> not do that also....

tools is using a deprecated API, so you'll have to do it at some
point. I don't think it's an inconvenience for anybody. If you decide
to upgrade to lttng-tools/lttng-ust/lttng-modules 2.6, it's not much
more work to upgrade urcu as well.

> David
