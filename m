From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: babeltrace cannot open the trace but Trace Compass
 can open
Date: Wed, 22 Jul 2020 11:06:16 -0400
Message-ID: <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
References: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 by lists.lttng.org (Postfix) with ESMTPS id 4BBf1w4mfgz1fB4
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jul 2020 11:06:44 -0400 (EDT)
Received: by mail-yb1-xb36.google.com with SMTP id a15so1167867ybs.8
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jul 2020 08:06:44 -0700 (PDT)
In-Reply-To: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Kim, Seongab" <Seongab.Kim@harman.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thank you for the bug report.

Can I kindly ask you to create an official issue for this?

Go to <https://bugs.lttng.org/projects/babeltrace/issues/new>.

I'd also like you to attach the offending CTF trace so that I can
analyze it if it doesn't contain sensitive data and is somewhat small.
If it's not possible, do:

    $ babeltrace2 -o ctf-metadata /mnt/ssd/work/skim/traces/kernel |
grep -A10 '^clock {'

and copy the output to the Redmine issue's description.

BR,

Phil

On Wed, Jul 22, 2020 at 9:17 AM Kim, Seongab via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Hi,
>
> I have a trace which cannot be opened by babeltrace as below, but I can open it with Trace Compass.
>
> skim@d54030999178:/mnt/ssd/work/skim/traces$ babeltrace2  ./kernel/
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR get_unary_unsigned@visitor-generate-ir.c:800 [auto-disc-source-ctf-fs] At line 40 in metadata stream: Invalid constant unsigned integer.
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR visit_clock_decl_entry@visitor-generate-ir.c:4357 [auto-disc-source-ctf-fs] At line 40 in metadata stream: Unexpected unary expression for clock class's `offset` attribute.
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR visit_clock_decl@visitor-generate-ir.c:4532 [auto-disc-source-ctf-fs] At line 40 in metadata stream: Cannot visit clock class's entry: ret=-22
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR ctf_visitor_generate_ir_visit_node@visitor-generate-ir.c:4775 [auto-disc-source-ctf-fs] At line 41 in metadata stream: Cannot visit clock class: ret=-22
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/DECODER ctf_metadata_decoder_append_content@decoder.c:337 [auto-disc-source-ctf-fs] Failed to visit AST node to create CTF IR objects: mdec-addr=0x22a0d90, ret=-22
> 07-22 07:49:20.099  5264  5264 E PLUGIN/SRC.CTF.FS/META ctf_fs_metadata_set_trace_class@metadata.c:128 [auto-disc-source-ctf-fs] Cannot update metadata decoder's content.
> 07-22 07:49:20.122  5264  5264 E PLUGIN/SRC.CTF.FS ctf_fs_component_create_ctf_fs_trace_one_path@fs.c:1206 [auto-disc-source-ctf-fs] Cannot create trace for `/mnt/ssd/work/skim/traces/kernel`.
> 07-22 07:49:20.123  5264  5264 W LIB/GRAPH add_component_with_init_method_data@graph.c:977 Component initialization method failed: status=ERROR, comp-addr=0x22a68d0, comp-name="auto-disc-source-ctf-fs", comp-log-level=WARNING, comp-class-type=SOURCE, comp-class-name="fs", comp-class-partial-descr="Read CTF traces from the file sy", comp-class-is-frozen=0, comp-class-so-handle-addr=0x22b0de0, comp-class-so-handle-path="/usr/lib/x86_64-linux-gnu/babeltrace2/plugins/babeltrace-plugin-ctf.so", comp-input-port-count=0, comp-output-port-count=0
> 07-22 07:49:20.123  5264  5264 E CLI cmd_run_ctx_create_components_from_config_components@babeltrace2.c:2301 Cannot create component: plugin-name="ctf", comp-cls-name="fs", comp-cls-type=1, comp-name="auto-disc-source-ctf-fs"
> 07-22 07:49:20.123  5264  5264 E CLI cmd_run@babeltrace2.c:2480 Cannot create components.
>
> ERROR:    [Babeltrace CLI] (babeltrace2.c:2480)
>   Cannot create components.
> CAUSED BY [Babeltrace CLI] (babeltrace2.c:2301)
>   Cannot create component: plugin-name="ctf", comp-cls-name="fs", comp-cls-type=1, comp-name="auto-disc-source-ctf-fs"
> CAUSED BY [libbabeltrace2] (graph.c:977)
>   Component initialization method failed: status=ERROR, comp-addr=0x22a68d0, comp-name="auto-disc-source-ctf-fs", comp-log-level=WARNING,
>   comp-class-type=SOURCE, comp-class-name="fs", comp-class-partial-descr="Read CTF traces from the file sy", comp-class-is-frozen=0,
>   comp-class-so-handle-addr=0x22b0de0, comp-class-so-handle-path="/usr/lib/x86_64-linux-gnu/babeltrace2/plugins/babeltrace-plugin-ctf.so",
>   comp-input-port-count=0, comp-output-port-count=0
> CAUSED BY [auto-disc-source-ctf-fs: 'source.ctf.fs'] (fs.c:1206)
>   Cannot create trace for `/mnt/ssd/work/skim/traces/kernel`.
>
> Could someone can advise me how to open the trace with babeltrace?
> I'm using below version.
>
> skim@d54030999178:~/work/tmp$ babeltrace2 -V Babeltrace 2.0.4 "Amqui"
>
> Amqui (/_mkwi_/) is a town in eastern Qu_bec, Canada, at the base of the Gasp_ peninsula in Bas-Saint-Laurent. Located at the confluence of the Humqui and Matap_dia Rivers, its proximity to woodlands makes it a great destination for outdoor activities such as camping, hiking, and mountain biking.
>
> Best regards,
> Seongab Kim
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
