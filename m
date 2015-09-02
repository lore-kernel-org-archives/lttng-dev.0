From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [RFC PATCH lttng-ust] Produce section with
	tracepoint callsite addresses
Date: Wed, 2 Sep 2015 17:50:17 -0400
Message-ID: <CAFXXi0=RMCLHF7H5oZmLc4=P6QpcrZZYy4bH8g4_j_NXYdXSuw__15730.802776716$1441230815$gmane$org@mail.gmail.com>
References: <1441230546-875-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1ZXFvg-00079E-NA
 for lttng-dev@lists.lttng.org; Wed, 02 Sep 2015 17:51:02 -0400
Received: by obuk4 with SMTP id k4so20166960obu.2
 for <lttng-dev@lists.lttng.org>; Wed, 02 Sep 2015 14:50:47 -0700 (PDT)
In-Reply-To: <1441230546-875-1-git-send-email-simon.marchi@polymtl.ca>
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

On 2 September 2015 at 17:49, Simon Marchi <simon.marchi@polymtl.ca> wrote:
> so that it's possible to determine where each tracepoint is used (and
> supporting tracepoints being called at multiple locations).  I made a
> prototype of gdb that reads the content of this section, available here:
>
>   https://github.com/simark/binutils-gdb.git

Oops, here's the link to the right branch:

  https://github.com/simark/binutils-gdb/tree/lttng
