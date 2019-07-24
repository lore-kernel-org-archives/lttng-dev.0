From: Yiteng Guo <guoyiteng@gmail.com>
Subject: Re: HugePages shared memory support in LLTng
Date: Wed, 24 Jul 2019 11:54:38 -0400
Message-ID: <CAO+PNdFc8XReaL+1hj9_Amfa+P_F5fjbGMeFter7hQZBBTczuQ__15495.0344747462$1563983715$gmane$org@mail.gmail.com>
References: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
 <20190715143302.GA2017@joraj-alpa>
 <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
 <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ@mail.gmail.com>
 <20190722192308.GA803@joraj-alpa> <20190723150744.GC803@joraj-alpa>
 <CAO+PNdGhEgeTo35du4ysMcCOUQ0PKE4tuyGg593AE5feZZ4_JQ@mail.gmail.com>
 <20190723202723.GD803@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by lists.lttng.org (Postfix) with ESMTPS id 45v0KQ3H48z1GDf
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2019 11:54:50 -0400 (EDT)
Received: by mail-wr1-x432.google.com with SMTP id n4so47633022wrs.3
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2019 08:54:50 -0700 (PDT)
In-Reply-To: <20190723202723.GD803@joraj-alpa>
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

(Forgot to cc mailing list in the previous email)

Hi Jonathan,

On Tue, Jul 23, 2019 at 4:27 PM Jonathan Rajotte-Julien
<jonathan.rajotte-julien@efficios.com> wrote:
>
> CC'ing the mailing list back.
>
> On Tue, Jul 23, 2019 at 03:58:09PM -0400, Yiteng Guo wrote:
> > Hi Jonathan,
> >
> > Thank you for the patch! It is really helpful.
>
> Were you able to observe a positive impact?
>
> This is something we might be interested in upstreaming if we have good
> feedback.

Yes, page faults disappeared and I didn't get those periodic overheads anymore.

And I also solved the problem that hugepages are not closed correctly
in my patch. It is my fault that I forgot to close the mmap pointer. I
updated the patch here:
https://github.com/lttng/lttng-ust/compare/master...guoyiteng:hugepages
The current prefault solution works well for me and I will use that
for now. In my opinion, using hugepages could further reduce the TLB
misses, but that involved more changes in source codes than the
prefault solution.

Best,
Yiteng
