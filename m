From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Sequence of strings
Date: Mon, 19 Jan 2015 19:16:03 -0500
Message-ID: <CAB4xu_3RVyy3R_rypKh7NdTD=hUaweBj=kQ5x+ZaOcu+M9oVLQ__5978.1048134484$1421713045$gmane$org@mail.gmail.com>
References: <CAC6yHM74MO8UN7d8B2WLj0EM8mZuhJLiaudGoSMDmNDOSwDa3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1YDMUp-0006el-8L
 for lttng-dev@lists.lttng.org; Mon, 19 Jan 2015 19:16:44 -0500
Received: by mail-lb0-f175.google.com with SMTP id z11so30946528lbi.6
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jan 2015 16:16:33 -0800 (PST)
In-Reply-To: <CAC6yHM74MO8UN7d8B2WLj0EM8mZuhJLiaudGoSMDmNDOSwDa3A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Jan 19, 2015 at 5:50 PM, Francis Giraldeau
<francis.giraldeau@gmail.com> wrote:
>
> Hi,
>
> I would like to record a sequence of strings. Here is an example:
>
> struct foo {
>   string _my_string;
> };
>
> event {
>   ...
>   fields := struct {
>     uint8_t _num;
>     struct foo _items[_num];
>   };
> };
>
> The program barectf does not allow it, and I wanted to know whether it's an implementation limitation or if CTF supports it at all.

Hi Francis,

CTF and Babeltrace certainly allow this.

It's a current barectf limitation: inner structures, as well as array/sequence
elements must have a fixed size. This is because they are currently copied
to the packet buffer as is using memcpy() with this precomputed fixed size.

Your best approach today is to precompute the total length of all the
concatenated strings (including terminating null characters) in your application
code, and use a sequence of bytes instead, also keeping the original number
of strings:

    event {
      ...
      fields := struct {
        uint32_t _len; /* length of all strings */
        uint8_t _num; /* number of concatenated strings */
        uint8_t _strings[_len];
      };
    };

Then, after running barectf, change this for:

    event {
      ...
      fields := struct {
        uint32_t _len;
        uint8_t _num;
        string _strings[_num];
      };
    };

and you should be able to see a sequence of strings in Babeltrace once
your streams are produced by barectf C code.

Ugly, but should work!

Supporting variable-length inner structures and array/sequence elements
is definitely on the TODO list for a future barectf release.

Thanks for the input,
Phil

>
> Thanks,
>
> Francis
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
