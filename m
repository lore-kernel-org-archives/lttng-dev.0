From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Babeltrace2 - compilation error with intel18
Date: Mon, 23 Mar 2020 11:44:35 -0400
Message-ID: <1c4447ea-b67a-eaf0-c9dd-d2c10106b5a7@simark.ca>
References: <CADtyBo7jFiv-E-DCp4kYfY7WRSLsN3Oos6iRr35Sy9o=iNZKOg@mail.gmail.com>
 <b2e4fcfb-eb65-5205-1de3-0e0dbfb7fb48@simark.ca>
 <CADtyBo7Qjjb_f=45oTaSw4d=dQd5YVt6A2r7z7R5WYrxZ4eVTg@mail.gmail.com>
 <60fcd0f0-e89c-5e04-8185-8cf34a92fe04@simark.ca>
 <CADtyBo44MW0=jBnrhh-aqfnrS8RtLAk9zbBZp3ktEhKACWPXdg@mail.gmail.com>
 <4bc0ec69-7587-fe58-691f-5cb23a11cd43@simark.ca>
Reply-To: Simon Marchi <simark@simark.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 48mJbZ5Nhxz1Qyh
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2020 11:44:42 -0400 (EDT)
In-Reply-To: <4bc0ec69-7587-fe58-691f-5cb23a11cd43@simark.ca>
Content-Language: tl
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Rocky Dunlap <dunlap@ucar.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2020-03-20 11:12 p.m., Simon Marchi via lttng-dev wrote:
> So since distutils really wants to compile the Python native modules using all the same
> flags as the Python interpreter was built with, I presume that they really assume that
> you'll be using the exact same toolchain to build your module as was used to build the
> interpreter.  Maybe we could just not pass CC/CFLAGS when building the Python module,
> so it will simply be built with the same compiler/linker as Python was built with, and
> we'll avoid all these problems...

If we want to go this route, here's a patch that implements it.

  https://review.lttng.org/c/babeltrace/+/3257

This makes it so we don't override the compiler or flags (other than necessary includes
flags) when building the native module.  So when configuring with CC=clang, the Python
native module gets built with the Python distribution's default compiler, with just the
flags it wants.

Could you check if that works with CC=icc as well?

Simon
