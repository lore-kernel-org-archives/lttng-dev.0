From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH lttng-tools] utils: Rework
	utils_parse_size_suffix
Date: Thu, 10 Apr 2014 14:43:38 -0400
Message-ID: <CAFXXi0=U55fJmSYQMDKcoX2zB-QDvD+dO=Rf4xCkqJcyVLYryQ__29808.1934256063$1397155513$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD3599C114@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1WYJxO-00036W-FL
 for lttng-dev@lists.lttng.org; Thu, 10 Apr 2014 14:44:19 -0400
Received: by mail-ig0-f170.google.com with SMTP id uq10so1143032igb.1
 for <lttng-dev@lists.lttng.org>; Thu, 10 Apr 2014 11:44:09 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD3599C114@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thanks for the comments.

> @@ -693,83 +660,94 @@ static void regex_print_error(int errcode, regex_t *regex)
> [...]
> +       /* strtoull will accept a negative number, but we don't want to. */
> +       if (strchr(str, '-') != NULL) {
> +               DBG("utils_parse_size_suffix: invalid size string, should not contain '-'.");
>                 ret = -1;
> +               goto end;
>         }
>

>>>>   Should be "[...] should not begin with '-' [...]" (although it is true the size string should not *contain*, the test is only for *begins with*)

I meant for it to search in the whole string, and that is what I think
strchr does.

> [...]
> +       if (num_end == str) {
> +               /* strtoull parsed nothing, not good. */
> +               DBG("utils_parse_size_suffix: strtoull had nothing good to parse.\n");
> +               ret = -1;
> +               goto end;
> +       }
>
>>>>   "utils_parse_size_suffix: zero-length size string." would be clearer.  Also note that the preceding DBG strings did not end with '\n'.

This test indeed will catch zero-length strings. However, iif you pass
"hello", or "k", strtoull will just parse 0 characters and return the
value 0. This test is for these cases as well, which are not
zero-length strings. I agree that it's not very clear, but I have
nothing better...
