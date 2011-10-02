/** 
 * @license Highcharts JS v2.1.6 (2011-07-08)
 * Prototype adapter
 * 
 * @author Michael Nelson, Torstein Hønsi.
 * 
 * Feel free to use and modify this script.
 * Highcharts license: www.highcharts.com/license.
 */
/* 
 * Known issues: 
 *    - Some grid lines land in wrong position - http://jsfiddle.net/highcharts/jaRhY/28
 */
// JSLint options:
/*jslint forin: true */
/*global Effect, Class, Highcharts, Event, $, $A */
// Adapter interface between prototype and the Highcarts charting library
var HighchartsAdapter=function(){var a=typeof Effect!="undefined";return{init:function(){a&&(Effect.HighchartsTransition=Class.create(Effect.Base,{initialize:function(a,b,c,d){var e,f;this.element=a,e=a.attr(b),b=="d"&&(this.paths=Highcharts.pathAnim.init(a,a.d,c),this.toD=c,e=0,c=1),f=Object.extend(d||{},{from:e,to:c,attribute:b}),this.start(f)},setup:function(){HighchartsAdapter._extend(this.element),this.element._highchart_animation=this},update:function(a){var b=this.paths;b&&(a=Highcharts.pathAnim.step(b[0],b[1],a,this.toD)),this.element.attr(this.options.attribute,a)},finish:function(){this.element._highchart_animation=null}}))},addEvent:function(a,b,c){a.addEventListener||a.attachEvent?Event.observe($(a),b,c):(HighchartsAdapter._extend(a),a._highcharts_observe(b,c))},animate:function(b,c,d){var e,f;d=d||{},d.delay=0,d.duration=(d.duration||500)/1e3;if(a)for(e in c)f=new Effect.HighchartsTransition($(b),e,c[e],d);else for(e in c)b.attr(e,c[e]);if(!b.attr)throw"Todo: implement animate DOM objects"},stop:function(a){a._highcharts_extended&&a._highchart_animation&&a._highchart_animation.cancel()},each:function(a,b){$A(a).each(b)},fireEvent:function(a,b,c,d){b.preventDefault&&(d=null),a.fire?a.fire(b,c):a._highcharts_extended&&a._highcharts_fire(b,c),d&&d(c)},removeEvent:function(a,b,c){$(a).stopObserving?$(a).stopObserving(b,c):(HighchartsAdapter._extend(a),a._highcharts_stop_observing(b,c))},grep:function(a,b){return a.findAll(b)},map:function(a,b){return a.map(b)},merge:function(){function a(b,c){var d;for(var e in c)d=c[e],d&&typeof d=="object"&&d.constructor!=Array&&typeof d.nodeType!="number"?b[e]=a(b[e]||{},d):b[e]=c[e];return b}function b(){var b=arguments,c={};for(var d=0;d<b.length;d++)c=a(c,b[d]);return c}return b.apply(this,arguments)},_extend:function(a){a._highcharts_extended||Object.extend(a,{_highchart_events:{},_highchart_animation:null,_highcharts_extended:!0,_highcharts_observe:function(a,b){this._highchart_events[a]=[this._highchart_events[a],b].compact().flatten()},_highcharts_stop_observing:function(a,b){a?b?this._highchart_events[a]=[this._highchart_events[a]].compact().flatten().without(b):delete this._highchart_events[a]:this._highchart_events={}},_highcharts_fire:function(a,b){(this._highchart_events[a]||[]).each(function(a){if(b&&b.stopped)return;a.bind(this)(b)}.bind(this))}})}}}()